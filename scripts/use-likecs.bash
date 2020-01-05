#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# use-likecs.bash
# author: Seong Yong-ju <sei40kr@gmail.com>

cd "$(dirname "$0")/.."

tmpdir="$(mktemp -d "${TMPDIR:-/tmp/}Competitive-Coding-XXXXXXXXXX")"
git clone https://github.com/likecs/Competitive-Coding "$tmpdir"


## C

echo
echo 'Importing C snippets from likecs/Competitive-Coding ...'
echo

find "${tmpdir}/C" \
     -mindepth 1 \
     -maxdepth 1 \
     -type d \
     -printf "%f\n" |
    tr '[:upper:]' '[:lower:]' |
    xargs -I{} mkdir -p 'snippets/c-mode/{}'

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

        echo -n " • ${group}/${key}"

        {
            echo '# -*- mode: snippet -*-'
            echo "# name: ${name}"
            echo '# contributor: Bhuvnesh Jain'
            echo "# key: ${key}"
            echo '# --'
            echo
            cat "$abspath"
        } >"snippets/c-mode/${group}/${key}"

        echo ' ... imported'
    done


## C++

echo
echo 'Importing C++ snippets from likecs/Competitive-Coding ...'
echo

find "${tmpdir}/C++14" \
     -mindepth 1 \
     -maxdepth 1 \
     -type d \
     -printf "%f\n" |
    tr '[:upper:]' '[:lower:]' |
    xargs -I{} mkdir -p 'snippets/c++-mode/{}'

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

        echo -n " • ${group}/${key}"

        {
            echo '# -*- mode: snippet -*-'
            echo "# name: ${name}"
            echo '# contributor: Bhuvnesh Jain'
            echo "# key: ${key}"
            echo '# --'
            echo
            cat "$abspath"
        } >"snippets/c++-mode/${group}/${key}"

        echo ' ... imported'
    done


## Python 3

echo
echo 'Importing Python snippets from likecs/Competitive-Coding ...'
echo

find "${tmpdir}/Python3" \
     -mindepth 1 \
     -maxdepth 1 \
     -type d \
     -printf "%f\n" |
    tr '[:upper:]' '[:lower:]' |
    xargs -I{} mkdir -p 'snippets/python-mode/{}'

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

        echo -n " • ${group}/${key}"

        {
            echo '# -*- mode: snippet -*-'
            echo "# name: ${name}"
            echo '# contributor: Bhuvnesh Jain'
            echo "# key: ${key}"
            echo '# --'
            echo
            cat "$abspath"
        } >"snippets/python-mode/${group}/${key}"

        echo ' ... imported'
    done

rm -rf "$tmpdir"
