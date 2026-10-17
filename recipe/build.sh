#!/usr/bin/env bash
set -euxo pipefail

# cmdliner bootstraps itself with `ocaml build.ml`; it has no build-system dependency.
# The upstream Makefile is driven by (MSYS2) make on every platform.
if [[ "${target_platform}" == win-* ]]; then
  # Forward-slash install prefix (as the cppo recipe does): the Makefile passes
  # these paths to install(1) and make, which choke on backslashes.
  INSTALL_PREFIX="$(cygpath -m "${PREFIX}")/Library"
else
  INSTALL_PREFIX="${PREFIX}"
fi

make all PREFIX="${INSTALL_PREFIX}"
make install \
  BINDIR="${INSTALL_PREFIX}/bin" \
  LIBDIR="${INSTALL_PREFIX}/lib/ocaml/cmdliner" \
  SHAREDIR="${INSTALL_PREFIX}/share" \
  MANDIR="${INSTALL_PREFIX}/share/man"
