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
        echo "Selecting map: $mapname"
        if curl --output /dev/null --silent --head --fail "${FASTDL}${mapname}.bsp.bz2"; then
            wget "${FASTDL}${mapname}.bsp.bz2"
            bzip2 -d $mapname.bsp.bz2
            mv $mapname.bsp $ENDPOINT
        else
            echo "BZip2 package not found on FastDL. Looking for BSP file instead."
            wget "${FASTDL}${mapname}.bsp"
            mv $mapname.bsp $ENDPOINT
        fi
    done < "$MAPLIST"                                                                                                       
    echo "Map List downloaded."                                                                                          
    exit 0
 else
    echo "Aborted."
    exit 0
fi
 
 
 
 
