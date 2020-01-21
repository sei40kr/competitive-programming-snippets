#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# use-kenkoooo.bash
# author: Seong Yong-ju <sei40kr@gmail.com>

cd "$(dirname "$0")/.."
# shellcheck source=../script_helpers/simple-tui/simple-tui.bash
. script_helpers/simple-tui/simple-tui.bash

# clone repository
tui_info "Cloning kenkoooo/competitive-programming-rs..."
tmpdir="$(mktemp -d "${TMPDIR:-/tmp/}competitive-programming-rs-XXXXXXXXXX")"
git clone -q https://github.com/kenkoooo/competitive-programming-rs "$tmpdir"


tui_group "Importing kenkoooo's snippets..."

# create group directories
find "${tmpdir}/src" \
     -mindepth 1 \
     -maxdepth 1 \
     -type d \
     ! -name 'utils' \
     -printf "%f\n" |
    tr '_' ' ' |
    xargs -I{} mkdir -p 'snippets/rust-mode/{}'

# create snippets
find "${tmpdir}/src" \
     -mindepth 2 \
     -maxdepth 2 \
     -type f \
     -name '*.rs' -a \
     ! -name 'mod.rs' \
     ! -path '*/utils/*' |
    while read -r abspath; do
        group="$(basename "$(dirname "$abspath")")"
        group="${group//_/ }"
        name="$(basename "$abspath" .rs)"
        name="${name//_/ }"
        key="${name// }"

        {
            echo '# -*- mode: snippet -*-'
            echo "# name: ${name}"
            echo '# contributor: Nakamura Kenko'
            echo "# key: ${key}"
            echo '# --'
            echo
            sed -n '/^#\[cfg(test)\]/q;p' "$abspath"
        } >"snippets/rust-mode/${group}/${key}"

        tui_done "Imported ${group}/${key}"
    done

tui_group_end


# clean up
rm -rf "$tmpdir"

tui_done 'Done'
