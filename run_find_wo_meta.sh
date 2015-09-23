#!/bin/bash

# 2015/08/28 - run on NukeCCInclusive pass

VERBOSEFLAG="--verbose"
VERBOSEFLAG=""

#
# Data
#
PLAYLISTFILE="$PRODUCTIONSCRIPTSROOT/data_scripts/playlists/minerva/playlist_minervame1A_me000z200i_EmptyH2O_EmptyHe.dat"

python FindAnaFilesWithoutMeta.py $VERBOSEFLAG \
  --dir /minerva/data/users/perdue/data_processing/grid/minerva/ana/numibeam/v10r8p3 \
  --playlist=$PLAYLISTFILE \
  --remove \
  --batch

#
# MC
#
python FindAnaFilesWithoutMeta.py $VERBOSEFLAG \
  --dir /minerva/data/users/perdue/mc_production/grid/central_value/minerva/ana/v10r8p3/00/11/72/00/ \
  --remove \
  --batch
