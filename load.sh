#!/bin/sh
sysctl -n vm.loadavg | sed 's/{//g' | sed 's/}//g' | awk '{$1=$1};1'
