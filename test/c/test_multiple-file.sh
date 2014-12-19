#!/bin/bash

# Tests
test "make with multiple files" \
  "make init" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.c ." \
  "cp ../resources/mathlib.c ." \
  "cp ../resources/mathlib.h ." \
  "make standard" \
  "make" \
  should_raise 0

test "if \"make\" builds the project with multiple files" \
  "make init" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.c ." \
  "cp ../resources/mathlib.c ." \
  "cp ../resources/mathlib.h ." \
  "make standard" \
  "make" \
  "./bin/a.out < ./data/simple_calc.dat" \
  should_output "4\n2\n27\n2\n1"
