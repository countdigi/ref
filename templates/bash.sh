#!/usr/bin/env bash

BASE=$(readlink -f $(dirname "$0")/..)
ME=$(basename $0)

usage() {
  echo "Usage: ${ME} [options]" 1>&2
  exit 1
}

myopts=$(getopt --options lyfh --longoptions list,yes,force,help -- "$@") || usage

eval set -- "${myopts}"

while true; do
  case $1 in
    -l|--list) do_list; shift;;
    -y|--yes) opt_force_install="yes"; shift;;
    -h|--help) usage ;;
    --) shift; break;;
    *) exit 1;;
  esac
  shift
done
