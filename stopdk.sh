#!/bin/sh
killtree() {
    local _pid=$1
    for _child in $(ps -o pid --no-headers --ppid ${_pid}); do
        killtree ${_child} ${_sig}
    done
    pids="$pids $_pid"
}
dk_pid=$(pidof ebook)
if [ x"$dk_pid" != x ]; then
    killtree ${dk_pid}
fi
kill -TERM $pids
