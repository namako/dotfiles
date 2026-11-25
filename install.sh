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
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WITH_BREW=1
[[ "${1:-}" == "--no-brew" ]] && WITH_BREW=0

if (( WITH_BREW )); then
    if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew ]]; then
        echo "==> Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"

    echo "==> brew bundle"
    # Continue even if a single entry fails (e.g. an app already installed by hand)
    brew bundle --file="$DOTFILES/Brewfile" || echo "!! some Brewfile entries failed; see above"
fi

echo "==> Linking dotfiles"
"$DOTFILES/dotfiles.sh"

echo
echo "Done. Open a new terminal (or run: exec zsh -l)."
