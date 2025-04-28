#!/bin/bash

check_file(){
  FILE=$1
  if [ ! -f "$FILE" ] || [ ! -s "$FILE" ]; then
  echo "mygrep: $FILE: No such file or directory or it has no content."
  exit 1
  fi
}
check_missing_args() {
  Argument_mode=$1  # Get the number of arguments passed to the function
  if [ $Argument_mode -eq 0 ] || [ $Argument_mode -eq 1 ]; then
    echo "This tool expect 2 or more arguments. Please provide a search string, optional flags and a file."
    echo "Usage: $0 <search_string> [options_flags] <file_path>"
    exit 1
  fi
}
check_missing_search_string() {
  if [ -z "$search_string" ]; then
    echo "mygrep: No search string provided."
    exit 1
  fi
}
mygrep_simple_search() {
  while IFS= read -r line; do
    if [[ $line =~ $Regex ]]; then
      Starting_Half="${BASH_REMATCH[1]}"
      Matching_Half="${BASH_REMATCH[2]}"
      Ending_Half="${BASH_REMATCH[3]}"
      echo -e "${Starting_Half} ${RED}$Matching_Half${ENDCOLOR}$Ending_Half"
    fi
  done < "$FILE"
}
parse_args() {
  local found_search_string=false
  for arg in "$@"; do
    if [[ "$arg" == -* ]]; then
      flags+=("$arg")
    elif [[ "$found_search_string" == false ]]; then
      if [ -f "$arg" ]; then
        check_file "$arg"
      else
        search_string="$arg"
        found_search_string=true
      fi
    else
      check_file "$arg"
    fi
  done
}

Argument_mode=$#
FILE="${!#}"
search_string=""
flags=()

check_missing_args $Argument_mode
check_file $FILE
parse_args "$@"
check_missing_search_string $search_string








echo "Search string is $search_string"
echo "Flags are ${flags[@]}"
echo "File is $FILE"


# mygrep_simple_search() {
#   while IFS= read -r line; do
#     if [[ $line =~ $Regex ]]; then
#       Starting_Half="${BASH_REMATCH[1]}"
#       Matching_Half="${BASH_REMATCH[2]}"
#       Ending_Half="${BASH_REMATCH[3]}"
#       echo -e "${Starting_Half} ${RED}$Matching_Half${ENDCOLOR}$Ending_Half"
#     fi
#   done < "$FILE"
# }

# pattern=$(( $# - 1 ))
# echo "Pattern Argument is $pattern"
# # Regex="^(.*)($pattern)(.*)$"
# Regex="^(.*)($1)(.*)$"

# RED="\e[31m"  
# ENDCOLOR="\e[0m"

# counter=0
# echo "Argument: $arg ${counter}"
# counter=$((counter + 1))






# mygrep_simple_search

# FILE=$3

# if [ -f $FILE ]; then
#    echo "File $FILE exists."
# else
#    echo "File $FILE does not exist."
# fi


# if [[ $String =~ ^$1 ]]; then
#   echo "Matches!"
# else
#   echo "No match!"
# fi
# case ${3,,} in 
#   -v)
#     echo "Inverted match"
#     ;;
#   -n)
#     echo "Line number"
#     ;;
#   -nv | -vn)
#     echo "Inverted match with line number"
#     ;;   
#   -h)
#     echo "Help"
#     ;;

#   *)
#     echo "Invalid option"
#     ;;
# esac

# Argu_1=$1
# if [$Argu_1 -eq '-v' || '-n']; then
#   Argu_2=$2
# fi



# mygrep_search() {
#   local match_flag=false
#   while IFS= read -r line; do
#     match_flag=false
#     if [[ $line =~ $Regex ]]; then
#     match_flag=True
#       # Starting_Half="${BASH_REMATCH[1]}"
#       # Matching_Half="${BASH_REMATCH[2]}"
#       # Ending_Half="${BASH_REMATCH[3]}"
#       # echo -e "${Starting_Half} ${RED}$Matching_Half${ENDCOLOR}$Ending_Half"
#     fi
#     if [ match_flag = true ]; then
#       echo " "
#     else
#       echo -e "$line"
#     fi
#     # echo "$line"
#     # echo "$line"
#   done < "$FILE"
# }

# mygrep_search