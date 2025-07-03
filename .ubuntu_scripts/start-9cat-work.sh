#!/bin/bash

# assumptions:
# - directories exist
# - alias exist

echo "[BOOTING UP TMUX]"

echo "[misc] creating new session"
cd
tmux new-session -d -s misc # -d is necessary to not attach to the session
tmux send-keys "c" C-m      # clearing is necessary or else will show the commands below
tmux send-keys "ff" C-m

echo "[9cat] creating new session"
cd ~/Documents/UnityProjects/9Cat-2d-2/
tmux new-session -d -s 9cat

echo "[9cat][window 1] setting up neovim"
# tmux send-keys "nvim" C-m
tmux send-keys "c" C-m
tmux send-keys "ff" C-m
tmux send-keys "ii" # sudo command for the user to decide if need to run

echo "[9cat][window 2] setting up lazygit"
tmux new-window
tmux send-keys "lg" C-m

echo "[9cat] setting window 1 as active window"
tmux select-window -p

echo "[editor] creating new session"
cd ~/Documents/UnityProjects/9cat-2d-level-editor/
tmux new-session -d -s editor

echo "[editor][window 1] setting up neovim"
# tmux send-keys "nvim" C-m
tmux send-keys "c" C-m
tmux send-keys "ff" C-m
tmux send-keys "ii 2"

echo "[editor][window 2] setting up lazygit"
tmux new-window
tmux send-keys "lg" C-m

echo "[editor][window 3] setting up yazi"
tmux new-window
tmux send-keys "y" C-m

echo "[editor] setting window 1 as active window"
tmux select-window -t 1

echo "[BOOTING UP BROWSERS]"
cd
zen --profile /home/gjtiquia/.zen/7gdo0vij.gjtiquia >/dev/null 2>&1 &
zen --profile /home/gjtiquia/.zen/wb02wm9b.gjtiquia-9cat/ >/dev/null 2>&1 &
zen --profile /home/gjtiquia/.zen/74ngvt8g.gjtiquia-public/ >/dev/null 2>&1 &

echo "[BOOTING UP OBSIDIAN]"
cd
obsidian >/dev/null 2>&1 &

echo "[BOOTING UP MESSAGING]" # whatsapp PWA and signal
cd
/snap/bin/chromium --profile-directory=Default --app-id=hnpfjngllnobngcgfapefoaidbinmjnm >/dev/null 2>&1 &
signal-desktop >/dev/null 2>&1 &

echo "[BOOTING UP SOURCEGIT]"
cd
sourcegit >/dev/null 2>&1 &

echo "[BOOTING UP UNITY EDITOR]"
cd
unityhub >/dev/null 2>&1 &

echo "[9cat] attaching"
tmux attach -t 9cat
