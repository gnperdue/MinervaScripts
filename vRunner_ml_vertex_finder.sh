#!/bin/sh

ANAVER=v10r8p7
OPTSLOC=$User_release_area/Minerva_${ANAVER}/Ana/NuclearTargetVertexing/options
OPTSFIL=$OPTSLOC/MLVFSamplePrepTool.opts

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
    --ana_tool MLVFSamplePrepTool \
    --opts $OPTSFIL \
    --inv v10r8p1 \
    --ingrid \
    --nocat \
    --kludge=Eroica \
    --no_verify_kludge $INTERACTIVESTRING
}

do_big_five_runs() {
    INTERACTIVESTRING=""
    dorun 1  > sublog_${STARTTIME}.txt 2>&1
    dorun 2 >> sublog_${STARTTIME}.txt 2>&1
    dorun 3 >> sublog_${STARTTIME}.txt 2>&1
    dorun 4 >> sublog_${STARTTIME}.txt 2>&1
    dorun 5 >> sublog_${STARTTIME}.txt 2>&1
}

do_small_one_run() {
    INTERACTIVESTRING="--interactive"
    dorun 1 1 200
}

do_small_five_runs() {
    INTERACTIVESTRING="--interactive"
    dorun 1 1 200
    dorun 2 1 200
    dorun 3 1 200
    dorun 4 1 200
    dorun 5 1 200
}

INTERACTIVESTRING=""
INTERACTIVESTRING="--interactive"

# do_big_five_runs

# do_small_one_run

do_small_five_runs

# dorun 1 2 
# dorun 2 1 
# dorun 3 1 
# dorun 4 1 



