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

echo "target $TARGET, nlearn $NLEARN, ntest $NTEST"
SKIMLEARN="skim_data_learn_target${TARGET}_${NLEARN}.dat"
SKIMTEST="skim_data_test_target${TARGET}_${NTEST}.dat"

REPORTFILE="liblin_${TARGET}_learn${NLEARN}_test${NTEST}.txt"

time ./svm-train $SKIMLEARN >& $REPORTFILE
./svm-predict $SKIMTEST ${SKIMLEARN}.model ${SKIMTEST}.predict >> $REPORTFILE
