#!/bin/bash 

ANATOOL="MLVFSamplePrepTool"
ANATOOL="NukeCCInclusive"

STARTTIME=`date +%Y-%m-%d-%H-%M-%S`
STARTDATE=`date +%Y%m%d`

# general running...
# MEMORY="2000MB"
# LIFETIME="3h"

# for subrun recovery
MEMORY="2100MB"
LIFETIME="4h"

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

do_five_full_mc_runs() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 117205  > sublog_${STARTTIME}.txt 2>&1
    dorun 117206  >> sublog_${STARTTIME}.txt 2>&1
    dorun 117207  >> sublog_${STARTTIME}.txt 2>&1
    dorun 117208  >> sublog_${STARTTIME}.txt 2>&1
    dorun 117209  >> sublog_${STARTTIME}.txt 2>&1
}

do_a_full_mc_run() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 117200  > sublog_${STARTTIME}.txt 2>&1
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

do_subrun_recovery() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"

    # not real recovery runs
    # dorun 117200 39,41 > sublog_${STARTTIME}.txt 2>&1
    # dorun 117201 1,2,3 >> sublog_${STARTTIME}.txt 2>&1

    dorun 10240 61,62,63,64,65,176,177,178,179,180,196,197,198,199,200 > sublog_${STARTTIME}.txt 2>&1
    # dorun 10241 46,47,48,49,50,81,82,83,84,85,101,102,103,104,105,141,142,143,144,145 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10242 17,36,37,38,39,40,156,157,158,159,160,171,172,173,174,175 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10243 24,25,26,27,28,39,40,41,42,43,84,85,86,87,88,124,125,126,127,128,144,145,146,147,148,185,186 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10244 31,45,46,47,48,49,90,91,92,93,94,137 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10245 50,51,52,53,54,65,101,102,103,104,105,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,186,187,188,189,190 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10246 18,34,35,36,37,38,39,40,41,42,43,49,50,51,52,53,94,95,96,97,98,104,105,106,107,108,116,130,131,132,133,134,152,176,177,178,179,180 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10247 10,11,12,13,14,108,146,147,148,149,150,176,177,178,179,180,191,192,193,194,195 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10248 11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45,46,47,48,49,50,76,77,78,79,80,121,122,123,124,125 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10249 6,7,8,9,10,86,87,88,89,90,126,127,128,129,130,141,142,143,144,145,151,152,153,154,155 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10200 33,50,51,52,53,54,65,66,67,68,69,105,106,107,108,109,110,111,112,113,114,135,136,137,138,139,145,146,147,148,149,155,156,157,158,159,162,196,197,198,199,200 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10201 19,20,21,22,23,66,112 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10202 14,70,71,72,73,74,105,106,107,108,109,110,111,112,113,114,115
# >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10203 19,25,26,27,28,29,30,36,37,38,39,40,51,52,53,54,55,66,67,68,69,70,81,82,83,84,85,91,92,93,94,95,101,102,103,104,105,106,107,108,109,110,156,157,158,159,160 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10204 14,15,16,17,18,24,25,26,27,28,74,85,86,87,88,89,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,135,136,137,138,139,190,191,192,193,194,196 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10205 19,20,21,22,23,29,30,31,32,33,34,120,121,122,123,124,150,151,152,153,154,196 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10206 40,41,42,43,44,65,66,67,68,69,105,106,107,108,109,115,116,117,118,119,153 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10207 9,10,11,12,13,43,50,51,52,53,54,70,71,72,73,74,90,91,92,93,94,95,96,97,98,99,115,116,117,118,119,165,166,167,168,169,175,176,177,178,179,180 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10208 6,7,8,9,10,31,32,33,34,35,61,62,63,64,65,66,67,68,69,70,81,82,83,84,85,161,162,163,164,165 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10209 38,45,65,66,67,68,69,70,75,87,88,89,90,91,92,105,114,115,116,117,118,127,155,156,157,158,159,161,186,187,188,189,190,191,192,193,194,195 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10210 14,15,16,17,18,24,29,31,42,43,44,45,46,47,48,49,50,51,62,63,64,65,66,73,103,104,105,106,107,121,146,160,161,162,163,164,190,191,192,193,194,195 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10211 16,17,18,19,20,51,52,53,54,55,76,77,78,79,80,106,107,108,109,110,141,142,143,144,145,146,147,148,149,150,186,187,188,189,190,196,197,198,199,200 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10212 62,63,64,65,66,82,93,94,95,96,97,98,99,100,101,102,103,137,140,141,142,143,144,195,196,197,198,199,200 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10213 14,45,48,49,50,51,52,58,59,60,61,62,66,69,125,126,127,128,129,135,136,137,138,139,186 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10214 6,7,8,9,10,16,17,18,19,20,36,37,38,39,40,56,57,58,59,60,66,79,82,85,90,91,92,93,94,150,151,152,153,154,163,166,167,168,169,170,181,182,183,184,185 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10215 16,22,34,43,54,55,56,57,58,64,65,66,67,68,84,94,106,107,108,109,110,126,127,128,129,130,131,132,133,134,135,161,162,163,164,165,196,197,198,199,200 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10216 32,40,41,42,43,44,85,86,87,88,89,90,91,92,93,94,105,106,107,108,109,125,138,149,150,164,165,166,167,168,169,188 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10217 13,15,37,38,39,40,41,47,48,49,50,51,52,53,54,55,56,61,63,64,65,66,67,72,85,118,171,172,173,174,175 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10218 13,18,40,41,42,43,44,58,76,77,78,79,80,87,93,97,114,115,116,117,118,119,120,121,122,123,139,140,141,142,143,165,185,186,187,188,189,200 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10219 33,34,35,36,37,40,114,115,116,117,118,119,120,121,122,123,144,145,146,147,148,149,150,151,152,153,167,171,186,187,188,189,190 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10220 2,18,27,28,40,41,42,43,44,60,61,62,63,64,95,96,97,98,99,100 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10221 41,42,43,44,45,71,72,73,74,75,121,122,123,124,125 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10222 51,52,53,54,55,106,107,108,109,110,176,177,178,179,180 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10223 5,6,7,8,9,30,31,32,33,34,100,166,167,168,169,170,186,187,188,189,190 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10224 11,12,13,14,15,76,77,78,79,80,81,82,83,84,85,126,127,128,129,130 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10225 6,7,8,9,10,101,102,103,104,105,106,107,108,109,110 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10226 1,2,3,4,5,16,17,18,19,20,26,27,28,29,30,31,32,33,34,35,71,72,73,74,75,81,82,83,84,85,131,132,133,134,135,161,162,163,164,165,181,182,183,184,185 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10227 11,12,13,14,15,101,102,103,104,105,111,112,113,114,115,121,122,123,124,125,131,132,133,134,135,141,142,143,144,145,186,187,188,189,190,191,192,193,194,195 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10228 5,6,7,8,9,50,51,52,53,54,60,61,62,63,64,70,71,72,73,74,128,161,162,163,164,165,186,187,188,189,190 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10229 26,27,28,29,30,86,87,88,89,90,186,187,188,189,190 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10230 6,60,101,102,103,104,105,141,142,143,144,145,156,157,158,159,160,186,187,188,189,190 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10231 10,11,12,13,14,85,86,87,88,89,93,108,117,118,119,120,121,130,145,146,147,151,152,153,154,155,196,197,198,199,200 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10232 11,12,13,14,15,26,27,28,29,30,76,77,78,79,80,96,97,98,99,100,116,117,118,119,120,141,142,143,144,145,146,147,148,149,150,156,157,158,159,160,161,162,163,164,165,191,192,193,194,195 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10233 1,2,3,4,5,16,17,18,19,20,121,122,123,124,125,136,137,138,139,140,141,142,143,144,145,156,157,158,159,160,171,172,173,174,175,181,182,183,184,185 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10234 16,17,18,19,20,26,27,28,29,30,106,107,108,109,110,131,132,133,134,135,171,172,173,174,175,191,192,193,194,195 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10235 11,12,13,14,15,26,27,28,29,30,31,32,33,34,35,126,127,128,129,130,146,147,148,149,150,161,162,163,164,165,186,187,188,189,190 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10236 30,71,72,73,74,75,171,172,173,174,175,196,197,198,199,200 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10237 15,16,17,18,19,20,21,22,23,24,120,121,122,123,124,125 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10238 21,22,23,24,25,56,57,58,59,60,76,77,78,79,80,101,102,103,104,105,156,157,158,159,160 >> sublog_${STARTTIME}.txt 2>&1
    # dorun 10239 66,67,68,69,70,81,82,83,84,85,91,92,93,94,95,161,162,163,164,165,166,167,168,169,170 >> sublog_${STARTTIME}.txt 2>&1
}

do_a_playlist() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    PLAYLIST="minerva1"
    doplaylist $PLAYLIST > sublog_${STARTTIME}.txt 2>&1
}

INTERACTIVESTRING=""
INTERACTIVESTRING="--interactive"

DATAMCSTRING="--data"
DATAMCSTRING="--mc"

# do_a_few_mc_subruns

# do_a_small_mc_sample

# do_a_full_mc_run

# do_five_full_mc_runs

do_subrun_recovery

# do_a_playlist

# MinervaMC run info...
# 117200 -> 117209(?) is minervame1A
# 112200 -> 112205(?) is minervame1B ? - looks plausible
# Run Range for playlist minerva1: [ 10200 - 10250 )

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
