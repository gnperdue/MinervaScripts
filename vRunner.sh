#!/bin/bash 

ANATOOL="MLVFSamplePrepTool"
ANATOOL="NukeCCInclusive"

STARTTIME=`date +%Y-%m-%d-%H-%M-%S`
STARTDATE=`date +%Y%m%d`

# general running...
MEMORY="2000MB"
LIFETIME="8h"

# for subrun recovery
# MEMORY="3000MB"
# LIFETIME="12h"

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
    --mc_var NoFSI --no_verify_kludge $INTERACTIVESTRING

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
    --mc_var NoFSI --no_verify_kludge $INTERACTIVESTRING
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
    --mc_var NoFSI --no_verify_kludge 

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
    --mc_var NoFSI --no_verify_kludge 
EOF
}

do_five_full_mc_runs() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 117205  > sublog_${STARTTIME}.txt 2>&1
    dorun 117206 >> sublog_${STARTTIME}.txt 2>&1
    dorun 117207 >> sublog_${STARTTIME}.txt 2>&1
    dorun 117208 >> sublog_${STARTTIME}.txt 2>&1
    dorun 117209 >> sublog_${STARTTIME}.txt 2>&1
}

do_a_full_mc_run() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 10200  > sublog_${STARTTIME}.txt 2>&1
}

do_a_few_mc_subruns() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 10200 1,2,3,4,5,6,7,8 > sublog_${STARTTIME}.txt 2>&1
}

do_a_small_mc_sample() {
    INTERACTIVESTRING="--interactive"
    DATAMCSTRING="--mc"
    dorun 117200 2 300
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
}

do_a_playlist() {
    INTERACTIVESTRING=""
    # DATAMCSTRING="--data"
    DATAMCSTRING="--mc"
    # PLAYLIST="minervame1A"
    PLAYLIST="minerva1"
    doplaylist $PLAYLIST > sublog_${STARTTIME}.txt 2>&1
}

INTERACTIVESTRING=""
INTERACTIVESTRING="--interactive"

DATAMCSTRING="--mc"
DATAMCSTRING="--data"

# do_a_few_mc_subruns

# do_a_small_mc_sample

# do_a_full_mc_run

# do_five_full_mc_runs

# do_subrun_recovery

do_a_playlist

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


# dorun 6207 1,2,3,4,5 > sublog_${STARTTIME}.txt 2>&1

# dorun 117200  > sublog_${STARTTIME}.txt 2>&1
# dorun 117200 1

# dorun 1  > sublog_${STARTTIME}.txt 2>&1
# dorun 2 >> sublog_${STARTTIME}.txt 2>&1
# dorun 3 >> sublog_${STARTTIME}.txt 2>&1

# dorun 1 2 

# dorun 1 1 200

# after two (and three) rounds of processing me1Amc (Eroica)
# perdue@minervagpvm02> python count_missing_subs.py ../MinervaScripts/missing_subruns.txt
# 117200 667
# 117201 184
# 117202 80
# 117203 63
# 117204 263
# 117205 190
# 117206 252
# 117207 465
# 117208 240
# 117209 152
# 2556
