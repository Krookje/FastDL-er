# FastDL-er
BASH script to automatically download a list of specified maps from a FastDL repository. Most convenient when setting up a new server and you need to download a mapcycle from a hosted FastDL.

## Requirements
- curl
- bzip2

```
sudo apt install wget curl bzip2
```

## Usage
```./mapdl.sh```

## Can I use this in srcds_run when launching my SourceMod server?

Yes. Just add `/bin/bash mapdl.sh` above the library loading section in your `srcds_run` script. 

![Yay](https://infra.s-ul.eu/ZWnE1d9m)

Depending on your panel, the terminal output may behave a bit weird (a good example of this is with Pterodactyl Panel). Just paste the required parameters in your terminal in order for it to start. Here's the order:
* Paste your FastDL Url and hit enter,
* Paste where your mapcycle.txt is located (eg: csgo/mapcycle.txt),
* Paste where you want the maps to go (eg: csgo/maps),
* Type "y" and hit enter to begin.


