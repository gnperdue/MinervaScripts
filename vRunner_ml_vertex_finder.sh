#!/bin/sh

OPTSLOC=$User_release_area/Minerva_v10r8p3/Ana/NuclearTargetVertexing/options
OPTSFIL=$OPTSLOC/RecoTracks.opts

INDIR=/minerva/data/users/goran/vertex_reco_samples_2015.07.28/
INDIR=/minerva/data/users/perdue/vertex_reco_samples_minos/

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

  # python -m pdb $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py --mc \
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py --mc \
    $RUNNSTRING \
    $SUBRSTRING \
    $NEVTSTRING \
    --indir $INDIR \
    --ana_tool RecoTracks \
    --opts $OPTSFIL \
    --inv v10r8p1 \
    --ingrid \
    --nocat \
    --kludge=Resurrection \
    --no_verify_kludge $INTERACTIVESTRING
}

INTERACTIVESTRING="--interactive"
INTERACTIVESTRING=""

dorun 1  > sublog_${STARTTIME}.txt 2>&1
dorun 2 >> sublog_${STARTTIME}.txt 2>&1
dorun 3 >> sublog_${STARTTIME}.txt 2>&1
dorun 4 >> sublog_${STARTTIME}.txt 2>&1
dorun 5 >> sublog_${STARTTIME}.txt 2>&1

# dorun 2 1 
# dorun 3 1 
# dorun 4 1 

# dorun 1 2 

# dorun 1 1 200
# dorun 2 1 200
# dorun 3 1 200
# dorun 4 1 200
# dorun 5 1 200

