#!/usr/bin/env bash

set -euxo pipefail

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

./configure --prefix=${PREFIX}        \
            --libdir=${PREFIX}/lib    \
            --build=${BUILD}          \
            --host=${HOST}

make -j${CPU_COUNT}

# Skip 'make check' when cross-compiling
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
  make check -j${CPU_COUNT}
fi

make install

for CHANGE in "activate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done
