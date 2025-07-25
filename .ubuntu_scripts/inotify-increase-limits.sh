#!/usr/bin/env bash

# from https://github.com/reaz1995/UnityNvimSupport?tab=readme-ov-file#3-extend-file-watching-limits-in-ubuntu

echo "current max_user_instances"
cat /proc/sys/fs/inotify/max_user_instances

echo "current max_user_watches"
cat /proc/sys/fs/inotify/max_user_watches

echo "current ulimit -n"
ulimit -n

# user instances (default: 128)
sudo sysctl -w fs.inotify.max_user_instances=1024
# sudo sysctl -w fs.inotify.max_user_instances=2048

# user watches (default 65536)
sudo sysctl -w fs.inotify.max_user_watches=1048576
# sudo sysctl -w fs.inotify.max_user_watches=2097152
# sudo sysctl -w fs.inotify.max_user_watches=4194304

echo "new max_user_instances"
cat /proc/sys/fs/inotify/max_user_instances

echo "new max_user_watches"
cat /proc/sys/fs/inotify/max_user_watches

echo "new ulimit -n"
ulimit -n
