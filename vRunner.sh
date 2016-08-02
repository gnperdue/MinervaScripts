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
LIFETIME="5h"

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
    # DATAMCSTRING="--mc"
    DATAMCSTRING="--data"

    # not real recovery runs
    # dorun 117200 39,41 > sublog_${STARTTIME}.txt 2>&1
    # dorun 117201 1,2,3 >> sublog_${STARTTIME}.txt 2>&1

    dorun 10114 26,27,28,29,30 > sublog_${STARTTIME}.txt 2>&1
    dorun 10116 42 >> sublog_${STARTTIME}.txt 2>&1
    dorun 10124 7 >> sublog_${STARTTIME}.txt 2>&1
    dorun 10068 1,2,15,16 >> sublog_${STARTTIME}.txt 2>&1
    dorun 10080 50 >> sublog_${STARTTIME}.txt 2>&1
    dorun 10099 31,32,33,34,35 >> sublog_${STARTTIME}.txt 2>&1
}

do_a_playlist() {
    INTERACTIVESTRING=""
    # DATAMCSTRING="--mc"
    DATAMCSTRING="--data"
    PLAYLIST="minervame1B"
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
