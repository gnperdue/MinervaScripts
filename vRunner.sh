#!/bin/bash 

ANATOOL="MLVFSamplePrepTool"
ANATOOL="NukeCCInclusive"
ANATOOL="NuECCQE"

STARTTIME=`date +%Y-%m-%d-%H-%M-%S`
STARTDATE=`date +%Y%m%d`

# general running...
MEMORY="2000MB"
LIFETIME="8h"

# for subrun recovery
# MEMORY="2500MB"
# LIFETIME="12h"

MCVARSTRING="--mc_var NoFSI"
MCVARSTRING=""

KLUDGESTR="--kludge Inextinguishable"

INVER="Inextinguishable"



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

  ARGS="--ana_tool $ANATOOL $DATAMCSTRING $INTERACTIVESTRING --inv $INVER --outdir $OUTDIR $RUNNSTRING $SUBRSTRING $NEVTSTRING $KLUDGESTR --memory $MEMORY --lifetime $LIFETIME $MCVARSTRING --tracker"

  pushd $PRODUCTIONSCRIPTSLITEROOT/ana_scripts/

cat <<EOF
    python ProcessAna.py $ARGS
EOF

  python ProcessAna.py $ARGS

  popd
}

doplaylist() {
  # First arg is playlist
  #
  # Note: playlists are never interactive
  PLAYLIST=$1
  PLAYLSTRING="--playlist $PLAYLIST"
  OUTDIR=/pnfs/minerva/persistent/users/perdue/mnv${DATAMCSTRING}${STARTDATE}

  ARGS="--ana_tool $ANATOOL $DATAMCSTRING --inv $INVER --outdir $OUTDIR $PLAYLSTRING $KLUDGESTR --memory $MEMORY --lifetime $LIFETIME $MCVARSTRING --tracker"

  pushd $PRODUCTIONSCRIPTSLITEROOT/ana_scripts/

cat <<EOF
    python ProcessAna.py $ARGS
EOF

  python ProcessAna.py $ARGS

  popd
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
    dorun 113270 1,2,3,4,5,6,7,8 > sublog_${STARTTIME}.txt 2>&1
}

do_a_small_mc_sample() {
    INTERACTIVESTRING="--interactive"
    DATAMCSTRING="--mc"
    dorun 113270 3 300
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

DATAMCSTRING="--data"
DATAMCSTRING="--mc"


# do_a_small_mc_sample
do_a_few_mc_subruns

# do_a_full_mc_run
# do_five_full_mc_runs
# do_subrun_recovery
# do_a_playlist
# do_a_few_data_subruns

# MinervaMC run info...
# perdue@minervagpvm04> cd $PRODUCTIONSCRIPTSROOT
# perdue@minervagpvm04> find . -name MCStandardRun.py
# ./py_classes/MCStandardRun.py
# perdue@minervagpvm04> python py_classes/MCStandardRun.py --playlist minerva13C
#
# and:
# https://cdcvs.fnal.gov/redmine/projects/minerva-sw/wiki/Inextinguishable_Monte_Carlo_Production_Run_Numbers
