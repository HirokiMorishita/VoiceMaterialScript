#!/bin/bash
input_file=$(fdfind --no-ignore -p -g '**/original/*.wav' | fzf)
if [ -n "$input_file" ]; then
  demucs -n htdemucs_ft -o $(dirname $input_file)/../vocal_only/ --filename "{stem}-$(basename $input_file)" --two-stems=vocals $input_file 
fi