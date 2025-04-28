#!/bin/bash

MYGREP="./mygrep.sh"
TESTFILE="testfile.txt"

# Simple helper to run and check
run_test() {
  description="$1"
  shift
  expected="$1"
  shift
  output=$("$@" 2>&1)

  if [[ "$output" == *"$expected"* ]]; then
    echo "[PASS] $description"
  else
    echo "[FAIL] $description"
    echo "  Expected to find: $expected"
    echo "  But got: $output"
  fi
}

# ----------------- TEST CASES -----------------

run_test "Missing all arguments" "This tool expect 2 or more arguments" $MYGREP

run_test "Missing search string" "mygrep: No search string provided." $MYGREP "$TESTFILE"

run_test "Missing file" "mygrep: tete: No such file or directory" $MYGREP -v tete

run_test "Invalid flag" "Invalid option: -k" $MYGREP -k line "$TESTFILE"

run_test "Missing file again" "mygrep: filenotexist.txt: No such file or directory" $MYGREP -v line filenotexist.txt

run_test "Simple search works" "Another test line" $MYGREP test "$TESTFILE"

run_test "Search with -n (line numbers)" "3: another test line" $MYGREP test -n "$TESTFILE"

run_test "Help message" "Help: This tool searches for a string in a file" $MYGREP --help

# ------------------------------------------------

echo
echo "Testing finished."
