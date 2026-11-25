#!/usr/bin/env bash
# Bootstrap a new Mac:
#   1. Homebrew (if missing)
#   2. Packages from Brewfile
#   3. Oh My Zsh + symlinks (dotfiles.sh)
#
# Usage:
#   git clone https://github.com/namako/dotfiles.git ~/dotfiles
#   ~/dotfiles/install.sh            # everything
#   ~/dotfiles/install.sh --no-brew  # symlinks only
#
# Exits non-zero if any step failed (even ones it continued past).
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WITH_BREW=1
[[ "${1:-}" == "--no-brew" ]] && WITH_BREW=0
FAILED=0

# Print the path of the brew executable (PATH, Apple Silicon, Intel), or fail.
find_brew() {
    local candidate
    for candidate in "$(command -v brew 2>/dev/null || true)" /opt/homebrew/bin/brew /usr/local/bin/brew; do
        if [[ -n "$candidate" && -x "$candidate" ]]; then
            echo "$candidate"
            return 0
        fi
    done
    return 1
}

if (( WITH_BREW )); then
    if ! BREW="$(find_brew)"; then
        echo "==> Installing Homebrew"
        # Download first so a failed fetch stops the script instead of running an empty script
        installer="$(mktemp)"
        trap 'rm -f "$installer"' EXIT
        curl -fsSL -o "$installer" https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
        /bin/bash "$installer"
        BREW="$(find_brew)" || { echo "!! Homebrew was installed but brew was not found" >&2; exit 1; }
    fi

    # Generate first: a failure inside eval "$(...)" would be silently ignored
    brew_env="$("$BREW" shellenv)"
    eval "$brew_env"

    echo "==> brew bundle"
    # Continue even if a single entry fails (e.g. an app already installed by hand),
    # but remember it so the script exits non-zero at the end
    if ! brew bundle --file="$DOTFILES/Brewfile"; then
        echo "!! some Brewfile entries failed; see above" >&2
        FAILED=1
    fi
fi

echo "==> Linking dotfiles"
"$DOTFILES/dotfiles.sh"

echo
if (( FAILED )); then
    echo "Finished with errors (see above). Open a new terminal (or run: exec zsh -l)." >&2
    exit 1
fi
echo "Done. Open a new terminal (or run: exec zsh -l)."
