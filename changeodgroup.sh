#!/bin/sh

# With this script installed as a payloadfree package by Deploystudio as a postponed installation I can move that computer from the original
# OD group to another. In the OD master these couple Macs didn't have the right computer+inventory name and I needed them applied other MCX settings.

# You need to change these settings to your own environment
# Because our Macs are bound to de OD they have a $ behind their name in the computer record.

computerName=$( scutil --get ComputerName );
COMPUTER_ID="${computerName}\$"
ODSERVER=/LDAPv3/dns-name.of.yourodserver
DIRADMIN=youroddiradmin
DIRPASSWD=yoursecretodpassword
REMOVEFROMGROUP=oldcompugroup
ADDTOGROUP=newcompgroup

# delete computer from original group
/usr/sbin/dseditgroup -o edit -n "$ODSERVER" -u "$DIRADMIN" -P "$DIRPASSWD" -d "$COMPUTER_ID" -L -t computer -T computergroup -q "$REMOVEFROMGROUP"

# Add to computergroup

/usr/sbin/dseditgroup -o edit -n "$ODSERVER" -u "$DIRADMIN" -P "$DIRPASSWD" -a "$COMPUTER_ID" -L -t computer -T computergroup -q "$ADDTOGROUP"
