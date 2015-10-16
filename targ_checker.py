#!/usr/bin/env python
"""
Usage:
    python targ_checker.py <dat file name>

Nice way to run over many files:
    for file in `ls -1 s*_test_targ*dat`; do python targ_checker.py $file; done
"""
from __future__ import print_function
import sys

if '-h' in sys.argv or '--help' in sys.argv:
    print(__doc__)
    sys.exit(1)

if not len(sys.argv) == 2:
    print('The dat file name is mandatory')
    print(__doc__)
    sys.exit(1)

datname = sys.argv[1]
predname = datname + '.predict'

datfile = open(datname, "r")
predfile = open(predname, "r")

datlines = datfile.readlines()
predlines = predfile.readlines()

datfile.close()
predfile.close()

assert(len(datlines) == len(predlines))

match = {}
n_true_targ = 0
n_true_other = 0
for i, lpred in enumerate(predlines):
    t = int(lpred[0])
    d = int(datlines[i][0])
    if d > 0:
        n_true_targ += 1
        success_key = "success " + str(d)
        fail_key = "fail " + str(d)
        if t == d:
            match[success_key] = match.get(success_key, 0) + 1
        else:
            match[fail_key] = match.get(fail_key, 0) + 1
    else:
        n_true_other += 1
        success_key = "success 0"
        fail_key = "fail 0"
        if t == d:
            match[success_key] = match.get(success_key, 0) + 1
        else:
            match[fail_key] = match.get(fail_key, 0) + 1

print("--------------------------")
for k in match:
    print(k, ":", match[k])

for k in match:
    if "0" in k:
        match[k] /= float(n_true_other)
    else:
        match[k] /= float(n_true_targ)

print("----")
for k in match:
    print(k, ":", match[k])
