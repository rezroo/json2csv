#!/bin/sh
set -ex
env

function gen_csv() {
  file=$1
  outline=$2
  for i in $(seq 0 5)
  do
    jq ".tests[$i]" $file | ../json2csv/json2csv.py -o sec-$(($i+1)).csv - $outline
  done
}

# main program
mkdir -p csv-files
cd ./docker-bench-security
./docker-bench-security.sh
mv docker-bench-security.sh.log.json ../csv-files
cd ../csv-files
gen_csv ./docker-bench-security.sh.log.json ../inner.outline.json
cd ..
zip -r docker-bench.zip csv-files/
mv docker-bench.zip csv-file/${HOSTNAME}-docker-bench.zip
