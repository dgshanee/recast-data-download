# recast-support

**Downloading Meteosat SEVIRI data from 2020-2024 to support the OVERCAST retro run**
* requires the epct-desktop conda env
* requires local installation of the HRIT data tailor
* currently set up on `jturner@overcast2:/home/jturner/overcast_recast_seviri`

**Running download:**
1. `conda activate epct-desktop`
2. start data tailor with `nohup epct_webui &>epct.log &` (likely will open a window in browser, this can be closed)
3. change start date (and any other settings) and run `nohup bash seviri_download_parallel.sh > eumdac_download_YYYYMMDD.log 2>&1 &`

Saving data to `/mnt/sat/seviri/europe_hrit/`, using format similar to `/mnt/meteosat/` used in YJ's CLAVR-x processing. 

**Monitoring progress:**
* In `/mnt/sat/seviri/europe_hrit/`, look for the latest directory date (they are added in chronological order), track the number of files within using `​​find <dir> -type f | wc -l`, this should be increasing each second
* Look for the running process with `ps aux | grep epct_webui | grep python`
* End process by using `kill <PID>` (takes around 10 min to shut down)

**Data domains:**
* 0 deg Meteosat centered over Europe -> EO:EUM:DAT:MSG:HRSEVIRI collection
* Indian Ocean Meteosat -> EO:EUM:DAT:MSG:HRSEVIRI-IODC

**Documentation for setup:**
* [EUMDAC (meteosat data access client)](https://user.eumetsat.int/resources/user-guides/eumetsat-data-access-client-eumdac-guide)
* [Local Data Tailor](https://user.eumetsat.int/resources/user-guides/eumetsat-data-access-client-eumdac-guide#ID-Data-Tailor-Standalone-in-EUMDAC)
