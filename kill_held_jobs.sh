#!/bin/bash
jobsub_rm -G minerva --role=Analysis  --jobid="`jobsub_q --user perdue | grep "GaudiAna" | grep "H" | cut -d ' ' -f 1 | tr '\n' ','`"
