for day in 2020-03-03
do
    day_nodash=${day//-/}
    dir="/mnt/sat/seviri/europe_hrit/$day_nodash"

    mkdir -p "$dir"

    eumdac download \
        -c EO:EUM:DAT:MSG:HRSEVIRI \
        --start ${day}T00:00:00 \
        --end   ${day}T23:59:59 \
        --chain "product: HRSEVIRI, format: hrit" \
        --local-tailor dt_3_2 \
        --output "$dir"
done