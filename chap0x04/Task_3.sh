#!/usr/bin/env bash

printHelp(){
  printf "usage: ./Task_3.sh [filename][arguments]\n\n"
  printf "Arguments:\n"
  printf " -th \t\t Statistics Access source host TOP 100 and the corresponding total number of occurrences,excluding IP and proxy\n"
  printf " -ti \t\t Statistics Access source host TOP 100 and the total number of occurrences corresponding,excluding hosts and prxy\n"
  printf " -tu \t\t Count the most frequently accessed URL TOP100\n"
  printf " -cs \t\t Count the number of occurrences and corrseponding percentages of different response status codes\n"
  printf " -c4s \t\t Statistics the TOP 10 corresponding to the different 4XX status codes and the total number of corresponding occurrences\n"
  printf " -osh \t\t Given URL output TOP 100 access Source host\n"
}

topHost(){
  filename="${1}"
  printf "\n<========Source host TOP 100========>\n"
  result=$( awk 'BEGIN{FS="\t"} $1 ~ /^(\w+\.)+[a-zA-Z]/ {print $1}' "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source host: %-35s\t Number: %d\n",$2,$1)}')
  echo "${result}"

  return 0
}

topIp(){
  filename="${1}"
  printf "\n<========Source Host TOP IP========>\n"
  result=$(awk 'BEGIN{FS="\t"} $1 ~ /([0-9]{1,3}\.){3}[0-9]{1,3}/ {print $1}' "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source IP: %-15s\t Number: %d\n",$2,$1)}')
  echo "${result}"

  return 0
}

topUrl(){
  filename="${1}"
  printf "\n<========Most frequently accessed URLS TOP 100========>\n"
  result=$(awk 'BEGIN{FS="\t"} $5 != "/" {print $5}' "${filename}" | sort | uniq -c | sort -nr | head -n 100)
  echo "${result}"

  return 0
}

countResponseStatus(){
  filename="${1}"
  printf "\n<========Response Status Code condition========>\n"
  sum=$(awk 'BEGIN{FS="\t";sum=0} $6 ~ /[0~9]/ {sum=sum+1} END {print sum}' "${filename}")
  result=$(awk 'BEGIN{FS="\t"} $6 ~ /[0~9]/{print $6}' "${filename}" | sort | uniq -c | sort -nr | awk 'BEGIN{FS=" "} {printf("Status code: %-10s\t Number: %-20d\t Percentage:%-4.5f%%\n",$2,$1,100*$1/'"${sum}"')}')
  echo "${result}"

  return 0
}

count4XXStatus(){
  filename="${filename}"

  printf "\n<=========4XX status codes URL TOP 10========>\n"

  codes=$(awk 'BEGIN{FS="\t"} $6 ~ /[4][0-9][0-9]/ {print $6}' "${filename}" | sort -u )

  echo "${codes}"

  for key in $codes
  do
    printf "Status code: %10s\n" "${key}"
    result=$(awk 'BEGIN{FS="\t"} $6=='"${key}"' {print $5}' "${filename}" | sort | uniq -c | sort -nr | head -n 10 )
    echo "${result}"
  done

  return 0
} 

outputSourceHost(){
  filename="${1}"
  url="${2}"

  printf "Input URL: %-10s\n" "${url}"
  result=$(awk 'BEGIN{FS="\t"} $5==ur {print $1} ' ur="${url}" "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source host: %-20s\t Number: %d\n",$2,$1)}')
  echo "${result}"

  return 0
} 

filename=${1}
shift
while [ -n "${1}" ]
do
  case "${1}" in

    -h|--help)
      printHelp
      ;;
    -th)
      topHost "${filename}"
      ;;
    -ti)
      topIp "${filename}"
      ;;
    -tu)
      topUrl "${filename}"
      ;;
    -cs)
      countResponseStatus "${filename}"
      ;;
    -c4s)
      count4XXStatus "${filename}"
      ;;
    -osh)
      url="${2}"
      outputSourceHost "${filename}" "${url}"
      shift
      ;;
    *)
      echo "ERROR:${1} is not a option"
      ;;
  esac
  shift
done
