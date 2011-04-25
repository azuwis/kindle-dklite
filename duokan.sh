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
        kill -TERM $pids
    fi
}

case "$1" in
start)
    /etc/init.d/framework stop
    if [ -n "`pidof ebook`" ]; then
        stop_duokan
    fi
    start_duokan
    ;;
stop)
    stop_duokan
    if [ -n "`pidof cvm`" ]; then
        /etc/init.d/framework restart
    else
        /etc/init.d/framework start
    fi
    ;;
*)
    ;;
esac
