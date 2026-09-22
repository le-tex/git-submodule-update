#!/usr/bin/env bash
# List submodules of a git working copy.
# Report properties defined in .gitmodules.
# Report expected hash and containing branches.
# Report current hash and containing branches.
# Report state (detached head or on a specific branch).
{
    set -o nounset

    # check for submodules
    if ! git submodule status >/dev/null 2>&1; then
        echo "No git submodules found. Exiting."
        exit 1
    fi

    git config --file .gitmodules --get-regexp path | cut -d' ' -f2 | while read submodulename; do
        echo "= submodule name: ${submodulename}"

        echo "== properties defined in .gitmodules:"
        git config --file .gitmodules --get-regexp ${submodulename}

        _hash_expected=$(git rev-parse HEAD:${submodulename})
        echo "== hash expected: ${_hash_expected}"
        echo "=== contained in branches:"
        git -C ${submodulename} branch --contains ${_hash_expected}

        _hash_current=$(git -C ${submodulename} rev-parse HEAD)
        echo "== hash current: ${_hash_current}"
        echo "=== contained in branches:"
        git -C ${submodulename} branch --contains ${_hash_current}

        _submodule_branch_current=$(git -C ${submodulename} branch --show-current)
        if [[ -z ${_submodule_branch_current} ]]; then
            echo "== state: detached head"
        else
            echo "== state: on branch '${_submodule_branch_current}'"
        fi
        echo;
    done
    
}; exit 0
