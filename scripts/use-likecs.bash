#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# use-likecs.bash
# author: Seong Yong-ju <sei40kr@gmail.com>

cd "$(dirname "$0")/.."
# shellcheck source=../script_helpers/simple-tui/simple-tui.bash
. script_helpers/simple-tui/simple-tui.bash

# clone repository
tui_info 'Cloning likecs/Competitive-Coding...'
tmpdir="$(mktemp -d "${TMPDIR:-/tmp/}Competitive-Coding-XXXXXXXXXX")"
git clone -q https://github.com/likecs/Competitive-Coding "$tmpdir"


tui_group 'Importing C snippets...'

# create group directories for c
find "${tmpdir}/C" \
     -mindepth 1 \
     -maxdepth 1 \
     -type d \
     -printf "%f\n" |
    tr '[:upper:]' '[:lower:]' |
    xargs -I{} mkdir -p 'snippets/c-mode/{}'

# create c snippets
find "${tmpdir}/C" \
     -mindepth 2 \
     -type f \
     -name '*.c' |
    while read -r abspath; do
        relpath="$(realpath --relative-to="${tmpdir}/C" "$abspath")"
        group="${relpath%%/*}"
        group="$(tr '[:upper:]' '[:lower:]' <<<"$group")"
        name="$(basename "$abspath" .c)"
        name="${name//_/ }"
        key="${name// }"
        key="$(tr '[:upper:]' '[:lower:]' <<<"$key")"

        {
            echo '# -*- mode: snippet -*-'
            echo "# name: ${name}"
            echo '# contributor: Bhuvnesh Jain'
            echo "# key: ${key}"
            echo '# --'
            echo
            cat "$abspath"
        } >"snippets/c-mode/${group}/${key}"

        tui_done "Imported ${group}/${key}"
    done

tui_group_end


tui_group 'Importing C++ snippets...'

# create group directories for c++
find "${tmpdir}/C++14" \
     -mindepth 1 \
     -maxdepth 1 \
     -type d \
     -printf "%f\n" |
    tr '[:upper:]' '[:lower:]' |
    xargs -I{} mkdir -p 'snippets/c++-mode/{}'

# create c++ snippets
find "${tmpdir}/C++14" \
     -mindepth 2 \
     -type f \
     -name '*.cpp' |
    while read -r abspath; do
        relpath="$(realpath --relative-to="${tmpdir}/C++14" "$abspath")"
        group="${relpath%%/*}"
        group="$(tr '[:upper:]' '[:lower:]' <<<"$group")"
        name="$(basename "$abspath" .cpp)"
        name="${name//_/ }"
        key="${name// }"
        key="$(tr '[:upper:]' '[:lower:]' <<<"$key")"

        {
            echo '# -*- mode: snippet -*-'
            echo "# name: ${name}"
            echo '# contributor: Bhuvnesh Jain'
            echo "# key: ${key}"
            echo '# --'
            echo
            cat "$abspath"
        } >"snippets/c++-mode/${group}/${key}"

        tui_done "Imported ${group}/${key}"
    done

tui_group_end


tui_group 'Importing Python snippets...'

# create group directories for python
find "${tmpdir}/Python3" \
     -mindepth 1 \
     -maxdepth 1 \
     -type d \
     -printf "%f\n" |
    tr '[:upper:]' '[:lower:]' |
    xargs -I{} mkdir -p 'snippets/python-mode/{}'

# create snippets
find "${tmpdir}/Python3" \
     -mindepth 2 \
     -type f \
     -name '*.py' |
    while read -r abspath; do
        relpath="$(realpath --relative-to="${tmpdir}/Python3" "$abspath")"
        group="${relpath%%/*}"
        group="$(tr '[:upper:]' '[:lower:]' <<<"$group")"
        name="$(basename "$abspath" .py)"
        name="${name//_/ }"
        key="${name// }"
        key="$(tr '[:upper:]' '[:lower:]' <<<"$key")"

        {
            echo '# -*- mode: snippet -*-'
            echo "# name: ${name}"
            echo '# contributor: Bhuvnesh Jain'
            echo "# key: ${key}"
            echo '# --'
            echo
            cat "$abspath"
        } >"snippets/python-mode/${group}/${key}"

        tui_done "Imported ${group}/${key}"
    done

tui_group_end


# clean up
rm -rf "$tmpdir"

tui_done 'Done'
