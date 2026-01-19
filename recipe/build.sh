#!/usr/bin/env bash

set -euxo pipefail

./configure --prefix=${PREFIX}        \
            --libdir=${PREFIX}/lib    \
            --build=${BUILD}          \
            --host=${HOST}

make -j${CPU_COUNT}
if [[ "$build_platform" == "$target_platform" ]]; then
  make check
fi
make install

for CHANGE in "activate" 
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done
