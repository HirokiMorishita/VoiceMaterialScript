#!/bin/bash

splitted_voice_directory=$(fdfind --no-ignore -p -g '**/splitted/*'| fzf)
if [ -n "$splitted_voice_directory" ] ; then
  python3 src/generate_index.py $splitted_voice_directory $splitted_voice_directory/index.csv
  code --reuse-window $splitted_voice_directory/index.csv
fi