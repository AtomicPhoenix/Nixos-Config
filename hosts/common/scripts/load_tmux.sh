# Grab an existing unattached session, if there are any
unattached_session="$(tmux ls | grep -v attached | head -1 | cut -d: -f1)"
# If no existing unattached sessions, create a new one
if [[ -z $unattached_session ]]; then
	tmux new-session
else
	# Attach to existing unattached session
	tmux attach-session -t "$unattached_session"
fi
