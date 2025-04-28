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
  if [ $Argument_mode -eq 0 ]; then
    echo "This tool expect 2 or more arguments. Please provide a search string, optional flags and a file."
    echo "Usage: $0 [OPTION]... PATTERN [FILE]..."
    echo "Try '$0 --help' for more information."
    exit 1
  fi
}

check_missing_search_string() {
  if [ -z "$search_string" ]; then
    echo "mygrep: No search string provided."
    exit 1
  fi
}

parse_args() {
  local found_search_string=false
  for arg in "$@"; do
    if [[ "$arg" == -* ]]; then
      flags+=("$arg")
      if [[ "$arg" == --help ]] then
        echo "$Help_message"
        exit 0
      fi
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

handle_flags() {
  local new_flags=()

  for flag in "${flags[@]}"; do
    case $flag in
      -v)
        new_flags+=("-v")
        ;;
      -n)
        new_flags+=("-n")
        ;;
      -nv | -vn)
        new_flags+=("-n" "-v")
        ;;
      --help)
        echo "$Help_message"
        exit 0
        ;;
      *)
        echo "Invalid option: $flag"
        exit 1
        ;;
    esac
  done

  # Update the global flags array
  flags=("${new_flags[@]}")
}


mygrep_simple_search() {
  local Regex=$1
  while IFS= read -r line; do
    lower_line=$(echo "$line" | tr '[:upper:]' '[:lower:]')
    lower_regex=$(echo "$Regex" | tr '[:upper:]' '[:lower:]')
    if [[ $lower_line =~ $lower_regex ]]; then
      Starting_Half="${BASH_REMATCH[1]}"
      Matching_Half="${BASH_REMATCH[2]}"
      Ending_Half="${BASH_REMATCH[3]}"
      echo -e "${Starting_Half} ${RED}$Matching_Half${ENDCOLOR}$Ending_Half"
    fi
  done < "$FILE"
}

mygrep_flag_supported_search() {
  local line_number=0
  local Regex=$1

  while IFS= read -r line; do
    line_number=$((line_number + 1))
    lower_line=$(echo "$line" | tr '[:upper:]' '[:lower:]')
    lower_regex=$(echo "$Regex" | tr '[:upper:]' '[:lower:]')

    if [[ " ${flags[@]} " =~ " -v " ]]; then
      # -v: Inverted match: only print lines that do NOT match
      if ! [[ $lower_line =~ $lower_regex ]]; then
        if [[ " ${flags[@]} " =~ " -n " ]]; then
          echo "${line_number}: $line"
        else
          echo "$line"
        fi
      fi

    else
      # Normal match
      if [[ $lower_line =~ $lower_regex ]]; then
        Starting_Half="${BASH_REMATCH[1]}"
        Matching_Half="${BASH_REMATCH[2]}"
        Ending_Half="${BASH_REMATCH[3]}"

        if [[ " ${flags[@]} " =~ " -n " ]]; then
          echo -e "${line_number}: ${Starting_Half}${RED}${Matching_Half}${ENDCOLOR}${Ending_Half}"
        else
          echo -e "${Starting_Half}${RED}${Matching_Half}${ENDCOLOR}${Ending_Half}"
        fi
      fi
    fi

  done < "$FILE"
}

Help_message="Help: This tool searches for a string in a file and highlights the matches.
              Usage: $0 <search_string> [options_flags] <file_path>
              Options:
                -v        Inverted match
                -n        Show line numbers
                -nv, -vn      Inverted match with line numbers
                --help  Show this help message
              Examples:
                $0 'search_string' -n file.txt
                $0 'search_string' -v file.txt
                $0 'search_string' -nv file.txt
                $0 'search_string' -h file.txt
                $0 'search_string' --help file.txt"



Argument_mode=$#

# Variable to hold the search string, Flags & File_path
FILE="${!#}"
search_string=""
flags=()
# Match Text Color
RED="\e[31m"  
ENDCOLOR="\e[0m"

# ---------------------------------- Calling the functions ----------------------------------
parse_args "$@"
check_missing_args $Argument_mode
check_file $FILE
check_missing_search_string $search_string
handle_flags "${flags[@]}"

Regex="^(.*)($search_string)(.*)$"

# mygrep_simple_search $Regex

mygrep_flag_supported_search $Regex

# ---------------------------------- Debugging ----------------------------------
# echo "Search string is $search_string"
# echo "Flags are ${flags[@]}"
# echo "File is $FILE"
# echo "Regex is $Regex"
# echo "Argument mode is $Argument_mode"