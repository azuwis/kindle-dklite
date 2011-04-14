#!/bin/sh
killtree() {
    local _pid=$1
    for _child in $(ps -o pid --no-headers --ppid ${_pid}); do
        killtree ${_child} ${_sig}
    done
    pids="$_pid $pids"
}

start_duokan() {
    export LD_LIBRARY_PATH=/mnt/us/DK_System/lib/:${LD_LIBRARY_PATH}
    chmod a+x /mnt/us/DK_System/bin/ebook
    /mnt/us/DK_System/bin/ebook >/dev/null 2>/dev/null &
}

stop_duokan() {
    dk_pid=$(pidof ebook)
    if [ x"$dk_pid" != x ]; then
        killtree ${dk_pid}
    fi
    if [ x"$dk_pid" != x ]; then
        kill -TERM $pids
    fi
}

start_kindle() {
    /etc/init.d/framework start
}

case "$1" in
start)
    start_duokan
    ;;
stop)
    stop_duokan
    start_kindle
    ;;
restart)
    stop_duokan
    start_duokan
    ;;
*)
    ;;
esac
