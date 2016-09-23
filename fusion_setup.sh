#!/bin/sh
# Created by Patrick van Nerum, Willem de Kooning academy
# Create a Fusion drive and split it up in 2 partitions. We use this second partition where students store their data.
# The partition volumes are as follows: 250GB Macintosh (system) 750GB DataStorage 
# Still needs some finishing touches
# It works for a 1 TB Fusion drive

# unmount disk

diskutil unmountDisk disk2

# Format the ssd and hdd
diskutil eraseDisk jhfs+ ssd disk0
diskutil eraseDisk jhfs+ hdd disk1

# Create the fusion drive
diskutil cs create Fusion disk0 disk1

sleep 5

VolumeGroupNew=`diskutil cs list | grep Logical\ Volume\ Group | sed -e "s/^.* //"`
diskutil cs createVolume $VolumeGroupNew jhfs+ Macintosh 100%

sleep 5

# Create the second partition

VolumeShrink=`diskutil cs list | grep Logical\ Volume | tail -1 |sed -e "s/^.* //"`
diskutil cs resizeStack $VolumeShrink 250g jhfs+ DataStorage 750g

exit 0
