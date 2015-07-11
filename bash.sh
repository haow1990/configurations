#!/bin/bash

# usage: doNewest cmd [options] [dir]
# the last param will be treated as dir only if it doesn't start with -
function doNewest() {
  if [ $# -lt 1 ]; then
    echo 'doNewest cmd [[options] [dir]' >&2
  fi

  cmd=$1
  shift
  while [[ "$1" == -* ]] || [[ $# -gt 1 ]]; do
    cmd+=" $1"
    shift
  done
  dir=${1:-.}
  file=$(ls --sort=time $dir | head -n 1)
  if [[ -n $file ]]; then
    $cmd $dir/$file
  fi
}


# usage: doNewestFile cmd [options] [dir]
# the last param will be treated as dir only if it doesn't start with -
function doNewestFile() {
  if [ $# -lt 1 ]; then
    echo 'doNewestFile cmd [[options] [dir]' >&2
  fi

  cmd=$1
  shift
  while [[ "$1" == -* ]] || [[ $# -gt 1 ]]; do
    cmd+=" $1"
    shift
  done
  dir=${1:-.}

  for file in $(ls --sort=time $dir); do
    if [[ -f $dir/$file ]]; then
      $cmd $dir/$file
      break
    fi
  done
}

# usage: doNewestDir cmd [options] [dir]
# the last param will be treated as dir only if it doesn't start with -
function doNewestDir() {
  if [ $# -lt 1 ]; then
    echo 'doNewestDir cmd [[options] [dir]' >&2
  fi

  cmd=$1
  shift
  while [[ "$1" == -* ]] || [[ $# -gt 1 ]]; do
    cmd+=" $1"
    shift
  done
  dir=${1:-.}

  for file in $(ls --sort=time $dir); do
    if [[ -d $dir/$file ]]; then
      $cmd $dir/$file
      break
    fi
  done
}

function lsnewest {
  doNewest ls $@
}

function catnewest {
  doNewestFile cat $@
}

function vinewest {
  doNewestFile vi $@
}

function tailnewest {
  doNewestFile tail $@
}

function cdnewest {
  doNewestDir cd $@
}

function newestfile {
  doNewestFile echo $@
}

function numberStat() {
awk '{if(min=="")min=$1; if(max=="") max$1; if($1<min) min=$1; if($1>max)max=$1; sum+= $1; sum2+=$1*$1; cnt+=1}END{mean=sum/cnt; if(cnt>0) print "min: ",min, "\nmax: ", max, "\nmean:", mean, "\nSD:  ", sqrt(sum2/cnt-mean*mean)}'
}

export -f lsnewest
export -f catnewest
export -f vinewest
export -f tailnewest
export -f cdnewest
export -f numberStat

# disable terminal flow control
stty -ixon

