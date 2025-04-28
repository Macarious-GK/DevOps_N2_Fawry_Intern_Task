#!/bin/bash
#
Argument_mode=$#
FILE=$2
Regex="^(.*)($1)(.*)$"
RED="\e[31m"  
ENDCOLOR="\e[0m"
declare -a my_array


mygrep_search() {
  while IFS= read -r line; do
    if [[ $line =~ $Regex ]]; then
      Starting_Half="${BASH_REMATCH[1]}"
      Matching_Half="${BASH_REMATCH[2]}"
      Ending_Half="${BASH_REMATCH[3]}"
      echo -e "${Starting_Half} ${RED}$Matching_Half${ENDCOLOR}$Ending_Half"
    fi
  done < "$FILE"
}

mygrep_search

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