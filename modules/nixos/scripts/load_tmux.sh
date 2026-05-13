#!/usr/bin/env bash
# Create new tmux server if one doesn't already exist
if ! tmux has-session 2>/dev/null; then
	tmux new-session
	exit 0
fi

# Grab the ID of an existing unattached session (if one exists)
unattached_session="$(tmux list-sessions -F "#{session_name}:#{session_attached}" 2>/dev/null | awk -F: '$2 == 0 {print $1; exit}')"

if [[ -z "$unattached_session" ]]; then
	# No unattached sessions; Create new session
	tmux new-session
else
	# Attach to existing unattached sessio
	tmux attach-session -t "$unattached_session"
fi
