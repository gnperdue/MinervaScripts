#!/bin/bash

TARGET=1
if [ $# -gt 0 ]; then
  TARGET=$1
fi

NLEARN=45000
if [ $# -gt 1 ]; then
  NLEARN=$2
fi

NTEST=5000
if [ $# -gt 2 ]; then
  NTEST=$3
fi

#
# assume we made files with names corresponding to the full set 
# learn number marker (0) with the requested number of events
#
FULLLEARN="skim_data_learn_target0_${NLEARN}.dat"
FULLTEST="skim_data_test_target0_${NTEST}.dat"

# 
# do we already have back-up files corresponding to these numbers?
# if so, make them the new base files (since we might not have 
# them otherwise)
#
if [[ -f ${FULLLEARN}.bak ]]; then
  mv ${FULLLEARN}.bak ${FULLLEARN}
fi
if [[ -f ${FULLTEST}.bak ]]; then
  mv ${FULLTEST}.bak ${FULLTEST}
fi

#
# if we didn't make those files, try to make them by looking at
# how big the full set files are if there are any with no numbers
#
if [[ ! -e $FULLLEARN ]]; then
    LEARNNAME="skim_data_learn_target0.dat"
    if [[ ! -e $LEARNNAME ]]; then
        echo "no way to figure out learning sample name, bailing"
        exit 1
    fi
    NLEARN=`wc -l $LEARNNAME | perl -ne '@l=split /\s+/,$_; print @l[0];'`
    FULLLEARN="skim_data_learn_target0_${NLEARN}.dat"
    mv $LEARNNAME $FULLLEARN
fi
if [[ ! -e $FULLTEST ]]; then
    TESTNAME="skim_data_test_target0.dat"
    if [[ ! -e $TESTNAME ]]; then
        echo "no way to figure out testing sample name, bailing"
        exit 1
    fi
    NTEST=`wc -l $TESTNAME | perl -ne '@l=split /\s+/,$_; print @l[0];'`
    FULLTEST="skim_data_test_target0_${NTEST}.dat"
    mv $TESTNAME $FULLTEST
fi

echo "target $TARGET, nlearn $NLEARN, ntest $NTEST"
echo "skimming $FULLLEARN, $FULLTEST"

SKIMLEARN="skim_data_learn_target${TARGET}_${NLEARN}.dat"
SKIMTEST="skim_data_test_target${TARGET}_${NTEST}.dat"
echo "to make $SKIMLEARN $SKIMTEST"

if [[ ! -f ${FULLLEARN} ]]; then
  echo "No learning file!"
  exit 1
fi
if [[ ! -f ${FULLTEST} ]]; then
  echo "No testing file!"
  exit 1
fi

python target_filter.py -f $FULLLEARN -t $TARGET
python target_filter.py -f $FULLTEST -t $TARGET

mv $FULLLEARN $SKIMLEARN
mv $FULLTEST $SKIMTEST

cp $SKIMLEARN ../liblinear
cp $SKIMTEST ../liblinear
mv $SKIMLEARN ../libsvm
mv $SKIMTEST ../libsvm
