#!/bin/bash

if [[ ${HOST} =~ .*darwin.* ]]; then
  # Attempt 1 (would prefer this route but does not work):
  # This bit works:
  # export PKG_CPPFLAGS="${CPPFLAGS} -fopenmp"
  # This bit Does nothing, will not appear on the link-line (though it looks to me like it *should*):
  # export PKG_LIBS="-fopenmp"
  #
  # Attempt 2 (stomps on ~/.R/Makevars but does work):
  # https://github.com/Rdatatable/data.table/wiki/Installation#openmp-enabled-compiler-for-mac
  [[ -d ~/.R ]] || mkdir -p ~/.R
  echo "CC=${CC} -fopenmp" > ~/.R/Makevars
fi

$R CMD INSTALL --build .

if [[ ${HOST} =~ .*darwin.* ]]; then
  rm -rf ~/.R
fi
