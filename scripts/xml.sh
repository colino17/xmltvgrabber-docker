#!/bin/bash

# REMOVE CACHE
rm -R cache
sleep 1

# DUMMY XMLTV
if [ $DUMMY = "true" ]; then
echo "Creating DUMMY XMLTV data..."
/bin/bash /dummy/dummyxmltv.sh
sleep 1
fi

# ZAP2XML - PRIMARY INSTANCE
if [ $Z1 = "true" ]; then
echo "Retrieving XMLTV data for $ZUSER1..."
/zap2xml.pl -u $ZUSER1 -p $ZPASS1 -U -o /xmltv/$ZXML1 $ZARG1
sleep 1
rm -R /cache
sleep 1
fi

# ZAP2XML - SECONDARY INSTANCE
if [ $Z2 = "true" ]; then
echo "Retrieving XMLTV data for $ZUSER2..."
/zap2xml.pl -u $ZUSER2 -p $ZPASS2 -U -o /xmltv/$ZXML2 $ZARG2
sleep 1
rm -R /cache
sleep 1
fi

# UPDATE XTEVE VIA API
if [ $XTEVE = "true" ]; then
echo "Updating XTEVE playlists and XMLTV..."
curl -X POST -d '{"cmd":"update.m3u"}' http://$XIP:$XPORT/api/
sleep 5
curl -X POST -d '{"cmd":"update.xmltv"}' http://$XIP:$XPORT/api/
sleep 5
curl -X POST -d '{"cmd":"update.xepg"}' http://$XIP:$XPORT/api/
sleep 5
fi

exit
