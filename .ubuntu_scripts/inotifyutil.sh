#!/usr/bin/env bash

Help() {
    echo
    echo "help:"
    echo
    echo "get             - reads current inotify max user instances and user watches"
    echo
    echo "set             - sets max instances and watches using preset 1"
    echo "set 1           - sets max instances and watches using preset 1"
    echo "set 2           - sets max instances and watches using preset 2"
    echo "set 4           - sets max instances and watches using preset 4"
    echo
    echo "set -i [NUMBER] - sets max instances to NUMBER"
    echo "set -w [NUMBER] - sets max watches to NUMBER"
    echo
}

Get() {
    echo
    echo "get:"
    echo
    echo "current max_user_instances"
    cat /proc/sys/fs/inotify/max_user_instances
    echo
    echo "current max_user_watches"
    cat /proc/sys/fs/inotify/max_user_watches
    echo
    echo "current ulimit -n"
    ulimit -n
    echo
}

SetMaxUserInstances() {
    echo
    sudo sysctl -w fs.inotify.max_user_instances=$1
    echo
}

SetMaxUserWatches() {
    echo
    sudo sysctl -w fs.inotify.max_user_watches=$1
    echo
}

Set() {
    echo
    echo "set:"

    # default values
    instance_count=128
    watch_count=65536

    if [[ $2 = "" ]] || [[ $2 = 1 ]]; then
        echo
        echo "using preset 1"
        echo
        instance_count=1024
        watch_count=1048576

    elif [[ $2 = 2 ]]; then
        echo
        echo "using preset 2"
        echo
        instance_count=2048
        watch_count=2097152

    elif [[ $2 = 4 ]]; then
        echo
        echo "using preset 4"
        echo
        instance_count=2048
        watch_count=4194304

    elif [[ $2 = "-i" ]] && [[ ! $3 = "" ]]; then
        echo
        echo "-i"
        echo
        echo "---"
        SetMaxUserInstances $3
        exit

    elif [[ $2 = "-w" ]] && [[ ! $3 = "" ]]; then
        echo
        echo "-w"
        echo
        echo "---"
        SetMaxUserWatches $3
        exit

    else
        echo
        echo "unrecognized input '$2'! perhaps you are missing a parameter? exiting..."
        echo
        exit

    fi

    echo "---"
    SetMaxUserInstances $instance_count
    echo "---"
    SetMaxUserWatches $watch_count
}

echo
echo "[inotifyutil]"

if [[ $1 = "help" ]]; then
    Help
    exit
fi

if [[ $1 = "get" ]]; then
    Get
    exit
fi

if [[ $1 = "set" ]]; then
    Set "$@" # pass script arguments as function arguments
    exit
fi

echo
echo "unknown command $1"
echo
echo "---"
Help
echo "---"
Get

exit
