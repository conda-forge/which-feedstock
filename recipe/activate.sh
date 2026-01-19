set -x
set -e
if [ "${SHELL}" = "/bin/bash" ]; then
    if [ "$(type -t which)" = "alias" ]; then
        unalias which
    elif [ "$(type -t which)" = "function" ]; then
        unset -f which
    fi
fi
