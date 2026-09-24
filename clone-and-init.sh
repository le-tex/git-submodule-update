#!/usr/bin/env bash
#
{
    set -o nounset

    function usage() {
        cat <<EOF
Usage: $(basename ${0}) <repository> [<directory>]
Wrapper for 'git clone --recurse-submodules <repository> [<directory>]'
EOF
    }

    if [[ ${#} -lt 1 ]] || [[ ${#} -gt 2 ]]; then
        usage
        exit 1
    fi

    REPOSITORY=${1}
    DIRECTORY=${2:-}

    git clone --recurse-submodules ${REPOSITORY} ${DIRECTORY}

}; exit 0
