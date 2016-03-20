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
    --dcacheout \
    --kludge Eroica \
    --no_verify_kludge $INTERACTIVESTRING

cat <<EOF
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $RUNNSTRING $SUBRSTRING $NEVTSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --dcacheout \
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
    --dcacheout \
    --kludge Eroica \
    --no_verify_kludge 

cat <<EOF
  time nice $PRODUCTIONSCRIPTSROOT/ana_scripts/ProcessAna.py \
    $DATAMCSTRING \
    $PLAYLSTRING \
    --ana_tool $ANATOOL \
    --inv eroica \
    --dcacheout \
    --kludge Eroica \
    --no_verify_kludge 
EOF
}

do_six_full_mc_runs() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"
    dorun 112200  > sublog_${STARTTIME}.txt 2>&1
    dorun 112201  >> sublog_${STARTTIME}.txt 2>&1
    dorun 112202  >> sublog_${STARTTIME}.txt 2>&1
    dorun 112203  >> sublog_${STARTTIME}.txt 2>&1
    dorun 112204  >> sublog_${STARTTIME}.txt 2>&1
    dorun 112205  >> sublog_${STARTTIME}.txt 2>&1
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
    dorun 112200 1 300
    # dorun 112200 2 200
}

do_subrun_recovery() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"

    dorun 112200 202,520,526,545,546,547,548,549,550,610,637,658,826,831,836,920,925,1074,1123,1130,1175,1178,1245,1248,1298,1343,1345,1351,1371,1448,1674,1727,1736,1739,1742,1751,1823,1955,1997,2006,2031,2036,2158,2321,2800,2886,3135,3237,3270,3314,3465,3511,3668,3687,3850,3857,4423,4888,4963 > sublog_${STARTTIME}.txt 2>&1
    dorun 112201 4,95,442,885,1254,1445,1782,1783,1784,1785,1786,1916,2350,2399,2521,2719,3059,3232,3299,3586,3746,3993,4631,4687,494 >> sublog_${STARTTIME}.txt 2>&11
    dorun 112202 434,438,481,485,486,488,489,490,500,508,511,513,517,525,526,554,555,567,568,569,571,575,612,614,615,618,620,624,625,645,646,647,648,649,652,654,655,661,678,684,716,719,720,722,726,728,736,749,750,751,753,766,808,813,817,820,825,826,827,828,829,830,831,832,834,837,856,857,877,879,880,891,892,906,921,966,968,994,1112,1201,1210,1282,1858,2135,2180,2550,2571,2610,2720,2932,2996,3164,3374,3378,3656,4319,4399 >> sublog_${STARTTIME}.txt 2>&11
    dorun 112203 235,570,829,1020,1035,1465,1769,1822,1917,2338,2378,2684,2691,2754,3039,3319,3429,3474,3572,3587,4168,4172,4779,488 >> sublog_${STARTTIME}.txt 2>&113
    dorun 112204 23,42,187,441,445,491,1007,1480,1511,1518,1598,1677,1688,1806,1897,2179,2365,2370,3359,3688,3712,3788,4213,4253,4574,4637,4686,4813,485 >> sublog_${STARTTIME}.txt 2>&116
    dorun 112205 45,292,462,638,1027,1148,1522,2130,2198,2259,3612,3809,3955,4209,4296,4328,4331,4338,4352,4726,4867 >> sublog_${STARTTIME}.txt 2>&11
}

INTERACTIVESTRING=""
INTERACTIVESTRING="--interactive"

DATAMCSTRING="--data"
DATAMCSTRING="--mc"

# do_a_few_mc_subruns

# do_a_small_mc_sample

# do_a_full_mc_run

# do_six_full_mc_runs

do_subrun_recovery


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
