#!/bin/bash

test "if \"make\" builds the shared library" \
  "make init" \
  "cp ../resources/shared_lib.cpp.mk Config.mk" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.cpp ." \
  "cp ../resources/mathlib.cpp ." \
  "cp ../resources/mathlib.hpp ." \
  "make standard" \
  "make" \
  "./bin/calculator < ./data/simple_calc.dat" \
  should_output "4\n2\n27\n2\n1"
