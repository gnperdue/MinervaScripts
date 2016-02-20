#!/bin/bash 

ANATOOL="MLVFSamplePrepTool"
ANATOOL="NukeCCInclusive"

STARTTIME=`date +%Y-%m-%d-%H-%M-%S`

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

  # python -m pdb ./ProcessAna.py --mc \
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $RUNNSTRING $SUBRSTRING $NEVTSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --ingrid \
    --kludge Eroica \
    --no_verify_kludge $INTERACTIVESTRING

cat <<EOF
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $RUNNSTRING $SUBRSTRING $NEVTSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --ingrid \
    --kludge Eroica \
    --no_verify_kludge $INTERACTIVESTRING
EOF
}

doplaylist() {
  # First arg is playlist
  #
  # Note: playlists are never interactive
  PLAYLIST=$1
  PLAYLSTRING="--playlist $PLAYLIST"

  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $PLAYLSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --ingrid \
    --kludge Eroica \
    --no_verify_kludge 

cat <<EOF
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $PLAYLSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --ingrid \
    --kludge Eroica \
    --no_verify_kludge 
EOF
}

do_two_full_mc_runs() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 112200  > sublog_${STARTTIME}.txt 2>&1
    dorun 112201  > sublog_${STARTTIME}.txt 2>&1
}

do_a_full_mc_run() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 117200  > sublog_${STARTTIME}.txt 2>&1
}

do_a_few_mc_subruns() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 117200 1,2,3,4,5,6,7,8,9,10,11,12 > sublog_${STARTTIME}.txt 2>&1
}

do_a_small_mc_sample() {
    INTERACTIVESTRING="--interactive"
    DATAMCSTRING="--mc"
    dorun 112200 1 200
    dorun 112200 2 200
}

INTERACTIVESTRING=""
INTERACTIVESTRING="--interactive"

DATAMCSTRING="--data"
DATAMCSTRING="--mc"

# do_a_few_mc_subruns

# do_a_small_mc_sample

# do_a_full_mc_run

do_two_full_mc_runs


# MinervaMC run info...
# 117200 -> 117209(?) is minervame1A
# 112200 -> 112205(?) is minervame1B ? - looks plausible


# data:
# http://cdcvs.fnal.gov/cgi-bin/public-cvs/cvsweb-public.cgi/AnalysisFramework/Tools/ProductionScripts/data_scripts/playlists/minerva/?cvsroot=mnvsoft
#
# mc:
# use `python MCStandardRun.py --help`

# doplaylist minervame1A > sublog_${STARTTIME}.txt 2>&1

# dorun 6207 1,2,3,4,5 > sublog_${STARTTIME}.txt 2>&1

# dorun 117200  > sublog_${STARTTIME}.txt 2>&1
# dorun 117200 1


# dorun 1  > sublog_${STARTTIME}.txt 2>&1
# dorun 2 >> sublog_${STARTTIME}.txt 2>&1
# dorun 3 >> sublog_${STARTTIME}.txt 2>&1

# dorun 1 2 

# dorun 1 1 200
