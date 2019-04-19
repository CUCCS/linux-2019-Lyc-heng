#!/usr/bin/env bash


showAll(){
  filename="${1}"
  statsAge "${filename}"
  statsPosition "${filename}"
  namelength "${filename}"

  return 0
}
printHelp(){
  printf "usage: ./Task_2.sh [filename][arguments]\n\n"
  printf "Arguments:\n"
  printf " -all \t\t Show all information\n"
  printf " -a \t\t Show age ,including maximum age and mimimum age\n"
  printf " -p \t\t Show position status\n"
  printf " -n \t\t Show the longest name and the shortest name\n"
  printf " -h \t\t Show help information\n"
}

statsAge(){

  filename="${1}"

  twenty=$(awk ' BEGIN{FS="\t"} $6<20 && NR != 1 {print $6}' "${filename}"|wc -l)

  twenty2thrity=$(awk ' BEGIN{FS="\t"} $6>=20 && $6 <= 30 && NR != 1 {print $6}' "${filename}"|wc -l)

  thrity=$(awk ' BEGIN{FS="\t"} $6>30 && NR != 1 {print $6}' "${filename}"|wc -l)

  total=$( wc -l < "${filename}")
  total=$(( "${total}" - 1))
  printf "\n<====================Age State====================>\n"
  printf "Number of athletes under 20 years of age:%4d people\n" "${twenty}"
  val=$(echo "scale=2;100*$twenty/$total"|bc)
  printf "Percentage:%4.2f%%\n" "${val}"
  printf "Number of players aged 20 to 30:%4d people\n" "${twenty2thrity}"
  val=$(echo "scale=2;100*$twenty2thrity/$total"|bc)
  printf "Percentage:%4.2f%%\n" "${val}"
  printf "Number of players over 30 years of age:%4d people\n" "${thrity}"
  val=$(echo "scale=2;100*$thrity/$total"|bc)
  printf "Percentage:%4.2f%%\n\n" "${val}"
  printf "\n<==========The oldest player==========>\n"
  oldest=$(awk ' BEGIN {FS="\t";maxage=0;maxname="none"} NR!=1 {if ($6>maxage) {maxage=$6;maxname=$9} } END {print "age: " maxage;print "name: "maxname}' "${filename}")
  echo "${oldest}"
  printf "\n<==========The youngest player==========>\n"
  youngest=$(awk ' BEGIN {FS="\t";minage=100;minname="none"} NR!=1 {if ($6<minage) {minage=$6;minname=$9} } END {print "age: " minage;print "name: "minname}' "${filename}")
  echo "${youngest}"

  return 0

}

statsPosition(){
  filename="${1}"

  total=$( wc -l < "${filename}")
  total=$(( "${total}" - 1))

  printf "\n<==========Player's on-site location information==========>\n"
  position=$(awk ' BEGIN {FS="\t"} NR!=1 {if ($5=="Défenseur") {print "Defender"} else {print $5} }' "${filename}" | sort -f | uniq -c )
  test=$(echo "${position}" | awk '{printf("Position:%-10s\tNumber:%d\tpercentage:%4.2f%%\n",$2,$1,100*$1/'"${total}"')}')
  echo "${test}" 

  return 0
}

namelength(){
  filename="${1}"

  printf "\n<==========The longest-named player==========>\n"
  longest=$(awk ' BEGIN {FS="\t";lolen=0;lona="none"} NR!=1 {if (length($9)>lolen) {lolen=length($9);lona=$9} } END {print lona}' "${filename}")
  echo "${longest}"

  printf "\n<==========The shortest-named player==========>\n"
  shortest=$(awk ' BEGIN {FS="\t";shlen=1000;shna="none"} NR!=1 {if (length($9)<shlen) {shlen=length($9);shna=$9} } END {print shna}' "${filename}")
  echo "${shortest}"

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
    -all)
      showAll "${filename}"
      ;;
    -a)
      statsAge "${filename}"
      ;;
    -p)
      statsPosition "${filename}"
      ;;
    -n)
      namelength "${filename}"
      ;;
    *)
      echo "ERROR:${1} is not an option"
      ;;
  esac
  shift
done

