#!/bin/bash

MAX_JOBS="$DATA_RETRIEVAL_MAX_JOBS"
START_DATE="$DATA_RETRIEVAL_START_DATE"
TIME_SPAN="$DATA_RETRIEVAL_TIME_SPAN"

echo $MAX_JOBS
echo $START_DATE
echo $TIME_SPAN

for ((i = 0; i < $TIME_SPAN; i++)); do #--- Set to run from 2021-03-03 to 2024-12-31
  day=$(date -d "$START_DATE + $i days" +"%Y-%m-%d")
  day_nodash=${day//-/}
  dir="/mnt/sat/seviri/europe_hrit/$day_nodash"

  mkdir -p "$dir"

  for hour in $(seq -w 0 23); do
    next_hour=$(printf "%02d" $((10#$hour + 1)))

    if [ "$next_hour" -eq 24 ]; then
      end_time="${day}T23:59:59"
    else
      end_time="${day}T${next_hour}:00:00"
    fi

    echo "Starting ${day} ${hour}:00"

    nice -n 10 eumdac download \
      -c EO:EUM:DAT:MSG:HRSEVIRI \
      --start "${day}T${hour}:00:00" \
      --end "${end_time}" \
      --chain "product: HRSEVIRI, format: hrit" \
      --local-tailor dt_3_2 \
      --output "$dir" &

    # Limit number of simultaneous jobs
    while [ "$(jobs -r | wc -l)" -ge "$MAX_JOBS" ]; do
      wait -n
    done
  done

  # Wait until every hour for this day has completed
  wait

  echo "===== Finished $day ====="

done
