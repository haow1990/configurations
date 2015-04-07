#!/bin/bash

function lsnewest {
  ls --sort=time $1 | head -n 1
}

function doNewestFile() {
  cmd=$1
  shift
  until [[ $# -le 1 ]]; do
    cmd+=" $1"
    shift
  done
  dir=$1

  for file in $(ls --sort=time $dir); do
    if [[ -f $file ]]; then
      $cmd $file
      break
    fi
  done
}

function doNewestDir() {
  cmd=$1
  shift
  until [[ $# -le 1 ]]; do
    cmd+=" $1"
    shift
  done
  dir=$1

  for file in $(ls --sort=time $dir); do
    if [[ -d $file ]]; then
      $cmd $file
      break
    fi
  done
}

function catnewest {
  doNewestFile cat " $@"
}

function vinewest {
  doNewestFile vi " $@"
}

function tailnewest {
  doNewestFile tail -f " $@"
}

function cdnewest {
  doNewestDir cd " $@"
}

export -f lsnewest
export -f catnewest
export -f vinewest
export -f tailnewest
export -f cdnewest

