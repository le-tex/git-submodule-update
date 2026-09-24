#!/usr/bin/env bash
#
{
    set -o nounset

    function usage() {
        cat <<EOF
Usage: $(basename ${0}) [<path>...]
Expects to be run inside a working copy of the superproject with initalized submodules.
Update submodules to HEAD of its remote-branch (defined submodule.<name>.branch).
If no <path> is given, update all submodules.
Otherwise update only submodules given by path.
EOF
    }

    # check for submodules
    if ! git submodule status >/dev/null 2>&1; then
        echo "No git submodules found. Exiting."
        exit 1
    fi

    git submodule update --remote --checkout ${*}

}; exit 0
