#!/usr/bin/env bash

BASE=$(readlink -f $(dirname "${BASH_SOURCE[0]}")/..)
NAME=$(basename "${BASH_SOURCE[0]}" .sh)

TEMP=${BASE}/tmp/${NAME}

usage() {
  echo "Usage: ${BASH_SOURCE[0]} <subcommand> [args...]" 1>&2
  echo "Subcommands: " 1>&2
  set | grep '^do_' | awk '{print $1}' | sed -e 's/do_//' -e 's/^/  /' | sort
}

do_method_a() {
  arg_a=$1; shift
  arg_b=$1; shift
  arg_remaining="$@"

  # do something
}

fname_a=/path/to/file_a.txt
fname_b=/path/to/file_b.txt

if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
  if [[ $# -lt 1 ]]; then
    usage
  else
    [[ -d ${TEMP} ]] || mkdir -p ${TEMP}
    command=$1; shift
    do_${command} "$@"
  fi
fi
