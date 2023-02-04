#!/bin/bash

read -r index_file_path target_line <<< "$(fdfind -I index.csv . | rg "${1:-.*}" | xargs rg --no-ignore --no-heading -v '^\s*$' 2>/dev/null | fzf --query "'" --delimiter ':' --nth 2.. | awk -F: '{print $1, $2}')"
( [[ -z "$index_file_path" ]] || [[ -z "$target_line" ]] ) && exit
target_file_path="$(dirname $index_file_path)/$(echo $target_line | cut -d , -f 1)"

if !(type open > /dev/null 2>&1); then
  _open() {
    if [ $# -ne 1 ]; then return 1; fi
    if [ -e "$1" ]; then
      local winpath=$(wslpath -w "$(readlink -f "$1")")
      powershell.exe start "\"${winpath}\""
    else
      powershell.exe start "$1"
    fi
  }
  _open $target_file_path
else
  open $target_file_path
fi
