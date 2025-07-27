#!/usr/bin/env bash

SESSION_NAME="dev"

# if session exists just attach
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  tmux attach-session -t "$SESSION_NAME"
  exit 0
fi

# start new session
tmux new-session -d -s "$SESSION_NAME" -n code

# left pane (nvim)
tmux send-keys -t "$SESSION_NAME:0.0" 'nvim' C-m

# split right
tmux split-window -h -t "$SESSION_NAME:0"
tmux resize-pane -t "$SESSION_NAME:0.0" -x 100

# right pane (empty for servers/commands/scripts/etc)
tmux send-keys -t "$SESSION_NAME:0.1" '' C-m

# focus back on nvim
tmux select-pane -t "$SESSION_NAME:0.0"

# attach
tmux attach -t "$SESSION_NAME"

