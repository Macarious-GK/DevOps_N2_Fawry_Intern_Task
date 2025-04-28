#!/bin/bash

MYGREP="./mygrep.sh"
TESTFILE="testfile.txt"

run_test() {
  expected="$1"
  shift
  output=$("$@" 2>&1)

  if [[ "$output" == *"$expected"* ]]; then
    echo "[PASS] $*"
  else
    echo "[FAIL] $*"
    echo "  Expected: $expected"
    echo "  Got: $output"
  fi
}

# ----------------- TEST CASES -----------------
run_test "This tool expect 2 or more arguments" $MYGREP
run_test "mygrep: No search string provided." $MYGREP "$TESTFILE"
run_test "mygrep: test: No such file or directory" $MYGREP -v test
run_test "Invalid option: -k" $MYGREP -k line "$TESTFILE"
run_test "mygrep: filenotexist.txt: No such file or directory" $MYGREP -v line filenotexist.txt
run_test "1: Hello world
2: This is a test
4: HELLO AGAIN
6: Testing one two three" $MYGREP -nv line "$TESTFILE"
run_test "Help: This tool searches for a string in a file" $MYGREP --help
# ------------------------------------------------

echo "All tests finished."
