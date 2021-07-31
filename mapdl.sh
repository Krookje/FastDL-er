#!/bin/bash

echo "Welcome to FastDL-er! https://github.com/1zc/FastDL-er"
echo " "
read -p 'FastDL URL (eg: https://fastdlv2.gflclan.com/file/gflfastdl/csgo/maps/) (Please ensure the URL ends with a /): ' FASTDL
read -p 'Maplist location (eg: csgo/mapcycle.txt): ' MAPLIST
read -p 'Location to place downloaded maps (eg: csgo/maps): ' ENDPOINT

echo " "
echo "Configured FastDL Repo: $FASTDL"
echo "Maplist to download: $MAPLIST"
echo "Configured download location: $ENDPOINT"
echo " "

read -r -p "Confirm the selected options and begin downloading? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    while IFS= read -r mapname
    do
        mapname=${mapname%$'\r'}
        mapname="${mapname%"S{mapname##*[![:space:]]}"}"
        echo "Selecting map: $mapname"
        if curl --output /dev/null --silent --head --fail "${FASTDL}${mapname}.bsp.bz2"; then
            echo -e "-- Collecting BZip2 package..."
            curl -k "${FASTDL}${mapname}.bsp.bz2" -o "${mapname}.bsp.bz2"
            echo -e "-- Unpacking BZip2 package..."
            bzip2 -d $mapname.bsp.bz2
            echo -e "-- Moving unpacked file to endpoint..."
            mv $mapname.bsp $ENDPOINT
            echo -e "-- Done.\n"
        elif curl --output /dev/null --silent --head --fail "${FASTDL}${mapname}.bsp"; then
            echo -e "-- BZip2 package was not found on FastDL, collecting BSP file instead..."
            curl -k "${FASTDL}${mapname}.bsp" -o "${mapname}.bsp"
            echo -e "-- Moving file to endpoint..."
            mv $mapname.bsp $ENDPOINT
            echo -e "-- Done.\n"
        else
            echo -e "-- Map was not found in provided FastDL Respository. Skipped.\n"
        fi
    done < "$MAPLIST"                                                                                                       
    echo -e "\n\nMap List completed."                                                                                          
    exit 0
 else
    echo -e "Aborted."
    exit 0
fi
