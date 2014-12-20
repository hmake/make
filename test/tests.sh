#!/bin/bash

. test/assert.sh
. test/helper.sh

function setup {
  mkdir test/tmp
  cp Makefile test/tmp/Makefile
  cd test/tmp
  if [[ "$OSTYPE" == "linux-gnu" ]]
  then
    echo "CC  := ${CC}"  >> .compiler.mk
    echo "CXX := ${CXX}" >> .compiler.mk
  fi
}

function teardown {
  cd ../..
  rm -rf test/tmp
}

# Targets
echo -n Testing Targets
. test/targets/test_init.sh
. test/targets/test_standard.sh
echo
assert_end Targets
echo

# C Tests
echo -n Testing C
. test/c/test_single-file.sh
. test/c/test_multiple-file.sh
. test/c/test_static-lib.sh
. test/c/test_shared-lib.sh
echo
assert_end "C Tests"
echo

# C++ Tests
echo -n Testing C++
. test/c++/test_single-file.sh
. test/c++/test_multiple-file.sh
. test/c++/test_static-lib.sh
. test/c++/test_shared-lib.sh
echo
assert_end "C++ Tests"
