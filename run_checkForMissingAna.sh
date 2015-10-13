#!/bin/bash

ANATOOL=NukeCCInclusive
NTUPLEPROCVER=v10r8p7

if [[ $ANATOOL == "NukeCCInclusive" ]]; then
    NTUPLEPROCVER=v10r8p3
fi

python ${PRODUCTIONSCRIPTSROOT}/production_tools/checkForMissingAna.py \
    --indir=/minerva/data/users/perdue/data_ana_minervame1A_August2015 \
    --inv=$NTUPLEPROCVER \
    --playlists=me1A \
    --ana_tool=$ANATOOL \
    --reco_version=eroica
