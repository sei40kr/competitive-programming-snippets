#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# use-kenkoooo.bash
# author: Seong Yong-ju <sei40kr@gmail.com>

cd "$(dirname "$0")/.."

tmpdir="$(mktemp -d "${TMPDIR:-/tmp/}competitive-programming-rs-XXXXXXXXXX")"
git clone https://github.com/kenkoooo/competitive-programming-rs "$tmpdir"

echo
echo 'Importing snippets from kenkoooo/competitive-programming-rs ...'
echo

find "${tmpdir}/src" \
     -mindepth 1 \
     -maxdepth 1 \
     -type d \
     ! -name 'utils' \
     -printf "%f\n" |
    tr '_' ' ' |
    xargs -I{} mkdir -p 'snippets/rust-mode/{}'

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

        echo -n " • ${group}/${key}"

        {
            echo '# -*- mode: snippet -*-'
            echo "# name: ${name}"
            echo '# contributor: Nakamura Kenko'
            echo "# key: ${key}"
            echo '# --'
            echo
            sed -n '/^#\[cfg(test)\]/q;p' "$abspath"
        } >"snippets/rust-mode/${group}/${key}"

        echo ' ... imported'
    done

rm -rf "$tmpdir"
