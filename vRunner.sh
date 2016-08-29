#!/bin/bash 

ANATOOL="MLVFSamplePrepTool"
ANATOOL="NukeCCInclusive"

STARTTIME=`date +%Y-%m-%d-%H-%M-%S`
STARTDATE=`date +%Y%m%d`

# general running...
# MEMORY="2000MB"
# LIFETIME="3h"

# for subrun recovery
MEMORY="3000MB"
LIFETIME="8h"

dorun() {
  # First arg is run, second (optional) is the subrun,
  # third (optional) is number of events
  # "Use" the 2nd and 3rd args if the numbers are non-zero
  RUNN=0
  SUBR=0
  NEVT=0
  RUNN=$1
  if [ $# -gt 1 ]; then
    SUBR=$2
  fi
  if [ $# -gt 2 ]; then
    NEVT=$3
  fi
  RUNNSTRING="--run $RUNN"
  if [[ $SUBR > 0 ]]; then
    SUBRSTRING="--subrun $SUBR"
  fi
  if [[ $NEVT > 0 ]]; then
    NEVTSTRING="-n $NEVT"
  fi
  OUTDIR=/pnfs/minerva/persistent/users/perdue/mnv${DATAMCSTRING}${STARTDATE}

  # python -m pdb ./ProcessAna.py --mc \
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $RUNNSTRING $SUBRSTRING $NEVTSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --outdir $OUTDIR \
    --kludge Eroica \
    --memory $MEMORY \
    --lifetime $LIFETIME \
    --no_verify_kludge $INTERACTIVESTRING

cat <<EOF
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $RUNNSTRING $SUBRSTRING $NEVTSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --outdir $OUTDIR \
    --kludge Eroica \
    --memory $MEMORY \
    --lifetime $LIFETIME \
    --no_verify_kludge $INTERACTIVESTRING
EOF
}

doplaylist() {
  # First arg is playlist
  #
  # Note: playlists are never interactive
  PLAYLIST=$1
  PLAYLSTRING="--playlist $PLAYLIST"
  OUTDIR=/pnfs/minerva/persistent/users/perdue/mnv${DATAMCSTRING}${STARTDATE}

  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $PLAYLSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --outdir $OUTDIR \
    --kludge Eroica \
    --memory $MEMORY \
    --lifetime $LIFETIME \
    --no_verify_kludge 

cat <<EOF
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $PLAYLSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --outdir $OUTDIR \
    --kludge Eroica \
    --memory $MEMORY \
    --lifetime $LIFETIME \
    --no_verify_kludge 
EOF
}

do_three_full_mc_runs() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 112203  > sublog_${STARTTIME}.txt 2>&1
    dorun 112204 >> sublog_${STARTTIME}.txt 2>&1
    dorun 112205 >> sublog_${STARTTIME}.txt 2>&1
}

do_a_full_mc_run() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 112202  > sublog_${STARTTIME}.txt 2>&1
}

do_a_few_mc_subruns() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 10200 1,2,3,4,5,6,7,8 > sublog_${STARTTIME}.txt 2>&1
    # dorun 10200 9,10,11,12,13,14,15,16 > sublog_${STARTTIME}.txt 2>&1
}

do_a_small_mc_sample() {
    INTERACTIVESTRING="--interactive"
    DATAMCSTRING="--mc"
    dorun 10200 1 300
}

do_a_few_data_subruns() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--data"
    dorun 6038 31,32,33,34 > sublog_${STARTTIME}.txt 2>&1
}

do_subrun_recovery() {
    INTERACTIVESTRING=""
    # DATAMCSTRING="--data"
    DATAMCSTRING="--mc"

    # not real recovery runs
    # dorun 117200 39,41 > sublog_${STARTTIME}.txt 2>&1
    # dorun 117201 1,2,3 >> sublog_${STARTTIME}.txt 2>&1

    dorun 13200 36 > sublog_${STARTTIME}.txt 2>&1
    dorun 13201 169 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13202 41,42,43,44,45 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13203 26,45,96 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13204 28,38,69,106,118,124,133,145,149,150,154,189,193,198 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13205 15,16,17,18,19,20,27,34,35,70,184 >> sublog_${STARTTIME}.txt
2>&1
    dorun 13206 25,45,57,89,119,145,156,162 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13207 4,7,29,31,33,48,49,53,55,65,67,68,74,82,94,96,119,124,128,132,159,181 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13208 12,23,29,48,51,66,72,80,92,96,103,107,116,118,125,160,164,167,174 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13209 7,8,12,17,26,28,29,49,87,90,134,154,180 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13210 20,31,48,65,72,88,106,107,124,131 >> sublog_${STARTTIME}.txt
2>&1
    dorun 13212 93,94,95,107,184 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13213 179 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13214 146 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13215 82,120,132,154 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13216 60,81,82,83,84,85 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13217 35,36,37,38,39,115 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13218 93,94,171 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13220 31 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13221 47,167 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13222 124,138,161 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13223 42,43,44 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13224 12,14,137,176 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13225 38,39,40,41,42,59,110,151 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13227 63,124 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13228 5,6,7,8,9,193 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13229 138,192 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13230 131,132,133,134,135 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13231 19,72,84,129,161,169,170,171,172,173,191,198 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13232 29,30,31,32,33,41,65,81,82,96,107,108,110,113,120,125,129,150,153,154,185,200 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13233 7,15,61,74,99,107,113,131,132,141,158,172,188,190,200 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13234 2,8,9,35,43,59,71,115,119,129,131,154,157,158,174,195 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13235 22,32,37,74,77,88,96,106 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13236 6,39,45,57,70,128,160,187 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13237 72,73,109,119,171,178 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13238 8,79,191,195 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13239 61,80,88,198 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13240 70 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13241 2,5,24,33,108,134,139,157,168 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13242 4,29,35,49,66,71,199 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13243 8,105,133,134,151,178,183 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13244 5,21,35,43,57,69,99,124,152,156,157,158,159,160 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13245 4,28,94,144,151,188 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13246 5,19,39,67,73,86,145,157,166 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13247 7,67,119,188,195 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13248 39,51,129,163 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13249 8,23,68,199 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13250 15,24,28,30,58,59,64,65,66,85,97,104,131,136,147,168,177 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13251 32 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13252 104 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13253 28,71,78,90,91,92,93,94,169 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13254 129 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13255 13,116,138 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13256 39 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13257 99,100,101,102,103,104,119 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13258 4,71 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13259 36,73 >> sublog_${STARTTIME}.txt 2>&1
    dorun 13260 7,182 >> sublog_${STARTTIME}.txt 2>&1
}

do_a_playlist() {
    INTERACTIVESTRING=""
    # DATAMCSTRING="--data"
    DATAMCSTRING="--mc"
    PLAYLIST="minerva13C"
    doplaylist $PLAYLIST > sublog_${STARTTIME}.txt 2>&1
}

INTERACTIVESTRING=""
INTERACTIVESTRING="--interactive"

DATAMCSTRING="--mc"
DATAMCSTRING="--data"

# do_a_few_mc_subruns

# do_a_small_mc_sample

# do_a_full_mc_run

# do_three_full_mc_runs

do_subrun_recovery

# do_a_playlist

# do_a_few_data_subruns

# MinervaMC run info...
# 117200 -> 117209(?) is minervame1A
# 112200 -> 112205(?) is minervame1B ? - looks plausible
# Run Range for playlist minerva1: [ 10200 - 10250 )
#
#  mc:
# perdue@minervagpvm04> cd $PRODUCTIONSCRIPTSROOT
# perdue@minervagpvm04> find . -name MCStandardRun.py
# ./py_classes/MCStandardRun.py
# perdue@minervagpvm04> python py_classes/MCStandardRun.py --playlist minerva13C
#
# and:
# https://cdcvs.fnal.gov/redmine/projects/minerva-sw/wiki/Monte_Carlo_Production_Run_Numbers

# data:
# http://cdcvs.fnal.gov/cgi-bin/public-cvs/cvsweb-public.cgi/AnalysisFramework/Tools/ProductionScripts/data_scripts/playlists/minerva/?cvsroot=mnvsoft
#
# mc:
# use `python MCStandardRun.py --help`
# e.g. python py_classes/MCStandardRun.py --playlist=minerva1


# doplaylist minervame1A > sublog_${STARTTIME}.txt 2>&1

# dorun 6207 1,2,3,4,5 > sublog_${STARTTIME}.txt 2>&1

# dorun 117200  > sublog_${STARTTIME}.txt 2>&1
# dorun 117200 1


# dorun 1  > sublog_${STARTTIME}.txt 2>&1
# dorun 2 >> sublog_${STARTTIME}.txt 2>&1
# dorun 3 >> sublog_${STARTTIME}.txt 2>&1

# dorun 1 2 

# dorun 1 1 200
