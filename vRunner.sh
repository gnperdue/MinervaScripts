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

do_subrun_recovery() {
    INTERACTIVESTRING=""
    DATAMCSTRING="--mc"

    # not real recovery runs
    # dorun 117200 39,41 > sublog_${STARTTIME}.txt 2>&1
    # dorun 117201 1,2,3 >> sublog_${STARTTIME}.txt 2>&1

    dorun 112200 202,520,526,546,610,637,658,826,831,836,920,925,1074,1123,1130,1175,1178,1245,1248,1286,1287,1288,1289,1290,1298,1343,1345,1351,1371,1448,1674,1727,1736,1739,1742,1751,1823,1955,1997,2006,2031,2036,2158,2321,2800,2886,3135,3237,3270,3314,3350,3351,3352,3353,3354,3465,3511,3512,3513,3514,3515,3516,3532,3533,3534,3535,3536,3668,3687,3749,3750,3751,3752,3753,3850,3857,4108,4109,4110,4111,4112,4118,4119,4120,4121,4122,4423,4464,4465,4466,4467,4468,4888,4963 > sublog_${STARTTIME}.txt 2>&1
    dorun 112201 4,95,442,885,1254,1445,1916,2323,2324,2325,2326,2327,2350,2399,2521,2719,3059,3073,3074,3075,3076,3077,3183,3184,3185,3186,3187,3232,3299,3300,3301,3302,3303,3304,3360,3361,3362,3363,3364,3465,3466,3467,3468,3469,3560,3561,3562,3563,3564,3586,3606,3607,3608,3609,3610,3721,3722,3723,3724,3725,3746,3782,3783,3784,3785,3786,3897,3898,3899,3900,3901,3912,3913,3914,3915,3916,3947,3948,3949,3950,3951,3993,4158,4159,4160,4161,4162,4198,4199,4200,4201,4202,4203,4204,4205,4206,4207,4228,4229,4230,4231,4232,4283,4284,4285,4286,4287,4518,4519,4520,4521,4522,4631,4679,4680,4681,4682,4683,4687,4715,4716,4717,4718,4719,4775,4776,4777,4778,4779,4860,4861,4862,4863,4864,4875,4876,4877,4878,4879,4941 >> sublog_${STARTTIME}.txt 2>&1
    dorun 112202 29,30,31,32,33,34,35,36,37,38,254,255,256,257,258,379,380,381,382,383,434,435,436,437,438,439,440,481,485,486,488,489,490,500,508,511,513,517,525,526,554,555,567,568,569,571,575,611,612,613,614,615,616,617,618,619,620,624,625,645,646,647,648,649,652,654,655,661,678,684,716,719,720,722,726,728,736,749,750,751,753,766,808,813,817,820,825,826,827,828,829,830,831,832,834,837,856,857,877,879,880,891,892,906,921,966,968,994,1087,1088,1089,1090,1091,1112,1163,1164,1165,1166,1167,1201,1210,1225,1226,1227,1228,1229,1282,1336,1337,1338,1339,1340,1366,1367,1368,1369,1370,1706,1707,1708,1709,1710,1751,1752,1753,1754,1755,1821,1822,1823,1824,1825,1836,1837,1838,1839,1840,1858,2135,2180,2309,2310,2311,2312,2313,2339,2340,2341,2342,2343,2550,2571,2586,2587,2588,2589,2590,2610,2720,2932,2996,3080,3081,3082,3083,3084,3164,3281,3282,3283,3284,3285,3374,3378,3656,3729,3730,3731,3732,3733,3909,3910,3911,3912,3913,3979,3980,3981,3982,3983,4079,4080,4081,4082,4083,4204,4205,4206,4207,4208,4299,4300,4301,4302,4303,4319,4399,4451,4452,4453,4454,4455,4541,4542,4543,4544,4545,4621,4622,4623,4624,4625,4851,4852,4853,4854,4855,4916,4917,4918,4919,4920 >> sublog_${STARTTIME}.txt 2>&1
    dorun 112203 47,48,49,50,51,62,63,64,65,66,147,148,149,150,151,167,168,169,170,171,222,223,224,225,226,235,408,409,410,411,412,570,719,720,721,722,723,829,830,831,832,833,834,845,846,847,848,849,920,921,922,923,924,1020,1035,1087,1088,1089,1090,1091,1097,1098,1099,1100,1101,1142,1143,1144,1145,1146,1162,1163,1164,1165,1166,1222,1223,1224,1225,1226,1257,1258,1259,1260,1261,1367,1368,1369,1370,1371,1457,1458,1459,1460,1461,1465,1488,1489,1490,1491,1492,1768,1769,1770,1771,1772,1773,1822,1850,1851,1852,1853,1854,1917,1936,1937,1938,1939,1940,1956,1957,1958,1959,1960,2156,2157,2158,2159,2160,2306,2307,2308,2309,2310,2326,2327,2328,2329,2330,2338,2378,2453,2454,2455,2456,2457,2533,2534,2535,2536,2537,2548,2549,2550,2551,2552,2643,2644,2645,2646,2647,2684,2691,2754,2886,2887,2888,2889,2890,2901,2902,2903,2904,2905,2996,2997,2998,2999,3000,3039,3042,3043,3044,3045,3046,3072,3073,3074,3075,3076,3177,3178,3179,3180,3181,3267,3268,3269,3270,3271,3319,3429,3474,3572,3587,3602,3603,3604,3605,3606,3687,3688,3689,3690,3691,3697,3698,3699,3700,3701,3847,3848,3849,3850,3851,3977,3978,3979,3980,3981,4037,4038,4039,4040,4041,4132,4133,4134,4135,4136,4168,4172,4279,4280,4281,4282,4283,4334,4335,4336,4337,4338,4369,4370,4371,4372,4373,4404,4405,4406,4407,4408,4434,4435,4436,4437,4438,4479,4480,4481,4482,4483,4499,4500,4501,4502,4503,4529,4530,4531,4532,4533,4699,4700,4701,4702,4703,4779,4845,4846,4847,4848,4849,4883,4891,4892,4893,4894,4895 >> sublog_${STARTTIME}.txt 2>&1
    dorun 112204 23,42,187,275,276,277,278,279,400,401,402,403,404,441,445,491,528,529,530,531,532,673,674,675,676,677,813,814,815,816,817,873,874,875,876,877,883,884,885,886,887,923,924,925,926,927,958,959,960,961,962,988,989,990,991,992,998,999,1000,1001,1002,1007,1229,1230,1231,1232,1233,1259,1260,1261,1262,1263,1294,1295,1296,1297,1298,1359,1360,1361,1362,1363,1389,1390,1391,1392,1393,1480,1511,1518,1527,1528,1529,1530,1531,1547,1548,1549,1550,1551,1598,1677,1688,1806,1896,1897,1898,1899,1900,1901,1952,1953,1954,1955,1956,2097,2098,2099,2100,2101,2122,2123,2124,2125,2126,2172,2173,2174,2175,2176,2179,2193,2194,2195,2196,2197,2203,2204,2205,2206,2207,2358,2359,2360,2361,2362,2365,2370,2470,2471,2472,2473,2474,2525,2526,2527,2528,2529,2585,2586,2587,2588,2589,2615,2616,2617,2618,2619,2650,2651,2652,2653,2654,2895,2896,2897,2898,2899,2925,2926,2927,2928,2929,2985,2986,2987,2988,2989,3040,3041,3042,3043,3044,3095,3096,3097,3098,3099,3100,3101,3102,3103,3104,3190,3191,3192,3193,3194,3240,3241,3242,3243,3244,3275,3276,3277,3278,3279,3280,3281,3282,3283,3284,3359,3486,3487,3488,3489,3490,3506,3507,3508,3509,3510,3516,3517,3518,3519,3520,3601,3602,3603,3604,3605,3646,3647,3648,3649,3650,3686,3687,3688,3689,3690,3691,3712,3788,3819,3820,3821,3822,3823,3939,3940,3941,3942,3943,3984,3985,3986,3987,3988,4034,4035,4036,4037,4038,4054,4055,4056,4057,4058,4174,4175,4176,4177,4178,4213,4253,4261,4262,4263,4264,4265,4356,4357,4358,4359,4360,4431,4432,4433,4434,4435,4511,4512,4513,4514,4515,4574,4577,4578,4579,4580,4581,4637,4686,4709,4710,4711,4712,4713,4813,4856,4916,4917,4918,4919,4920
    dorun 112205 >> sublog_${STARTTIME}.txt 2>&1

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

# do_three_full_mc_runs

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
