#!/usr/bin/env bash
usage() {
	cat <<'EOF'
Usage: rebuild [--help] [flakeOutputAttribute]

Rebuild NixOS system using flake using the specified flake output attribute.

If no attribute is provided, the system hostname is used as the default.
EOF
}

# Confirm only 0 or 1 arguments passed
if [[ $# -gt 1 ]]; then
	usage
	exit 1
fi

if [[ "${1:-}" == "--help" ]]; then
	usage
	exit 0
fi

# Determine which output attribute to rebuild with
flakeAttr="${1:-}"

if [[ -z "$flakeAttr" ]]; then
	# Use hostname from system configuration as output attribute if unspecified
	flakeAttr="$(hostname)"
	printf "\033[0;33mWARNING: \033[0mNo output attribute specified. Defaulting to using hostname (%s) as flake output attribute...\n" "$flakeAttr"
fi

# List of valid output attribute
valid_attrs=$(
	nix flake show ~/Nixos-Config 2>/dev/null |
		sed -r 's/\x1b\[[0-9;]*m//g' |
		tail -n +3 |
		sed -E 's/.*[├└]───([^:]+):.*/\1/' |
		tr -d '\r'
)

# Confirm flakeAttr is a valid output attribute
if ! grep -qxF "$flakeAttr" <<<"$valid_attrs"; then
	printf "\033[31mERROR: \033[0mInvalid output attribute \"%s\".\n" "$flakeAttr"
	printf "Valid output attribute(s): \n"
	printf -- "- %s\n" "${valid_attrs//$'\n'/$'\n- '}"
	exit 1
fi

printf "System will be rebuilt using the selected flake (%s)\n" "$flakeAttr"
printf " Rebuilding...\n\n"

SECONDS=0
sudo nixos-rebuild switch --show-trace --flake ~/Nixos-Config/#"$flakeAttr"
SUCCESS=$?

minutes=$((SECONDS / 60))
seconds=$((SECONDS % 60))
if ((minutes == 0)); then
	elapsed_time="${seconds}s"
else
	elapsed_time="${minutes}m ${seconds}s"
fi

if ((SUCCESS == 0)); then
	printf "\nRebuild succeeded in %s.\n" "$elapsed_time"
else
	printf "\n\033[31mERROR: \033[0mRebuild failed in %s.\n" "$elapsed_time"
	exit 1
fi

# Optional per-host hook
if command -v post_rebuild >/dev/null 2>&1; then
	echo "Running post rebuild hook..."
	post_rebuild
fi
