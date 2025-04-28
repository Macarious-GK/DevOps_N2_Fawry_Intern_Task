#!/bin/bash

String=$2

if [[ $String =~ ^$1 ]]; then
  echo "Matches!"
else
  echo "No match!"
fi