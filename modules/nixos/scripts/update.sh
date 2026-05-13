#!/usr/bin/env bash
usage() {
        cat <<'EOF'
Usage: update [--commit] [--no-commit] [--help]

Update Nix flake and optionally commit flake.lock changes.

Options:
  --commit      Skip prompt and automatically commit flake.lock if changed
  --no-commit   Skip prompt and automatically skip committing flake.lock 
  --help        Show this help message
EOF
}

commit_update() {
        echo "Committing flake.lock..."
        if [[ "$(git rev-parse --abbrev-ref HEAD)" != "main" ]]; then
                printf "\033[31mERROR: \033[0mNot currently on main branch. Cannot commit flake.lock automatically.\n"
                return 1
        fi

        # Ensure there are no existing staged changes
        if ! git diff --cached --quiet; then # Non-zero exit code means staged changes exist
                printf "\033[31mERROR: \033[0mExisting staged changes. Cannot commit flake.lock automatically.\n"
                return 1
        fi

        (git add flake.lock && git commit -m "Updated flake.lock") || return 1

        echo "flake.lock successfully committed"
}

# Confirm only 0 or 1 arguments passed
if [[ $# -gt 1 ]]; then
        usage
        exit 1
fi

auto_commit=0

case "${1:-}" in
--help)
        usage
        exit 0
        ;;
--commit)
        auto_commit=1
        ;;
--no-commit)
        auto_commit=2
        ;;
"") ;;
*)
        usage
        exit 1
        ;;
esac

# Move into repo
cd ~/Nixos-Config || exit 1

# Update Flake
if ! nix flake update; then
        printf "\033[31mERROR: \033[0mFailed to update system flake.\n"
        exit 1
fi

# Check if anything was updated
if git diff --quiet flake.lock; then
        echo "flake.lock unchanged."
        exit 0
fi
echo 'Successfully updated system flake'

# Commit update if user wants
if [[ "$auto_commit" -eq 1 ]]; then
        commit_update
        exit
elif [[ "$auto_commit" -eq 2 ]]; then
        echo "Skipping commit."
        exit 0
else
        read -rp "Commit updated flake.lock? (y/n): " answer
        case "$answer" in
        [Yy])
                commit_update
                exit
                ;;
        *)
                echo "Skipping commit"
                exit 0
                ;;
        esac
fi
