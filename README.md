# NOTICE

It appears that the Zap2It site and service have been killed by the site owner, therefore this container no longer works as it has nothing to query anymore. I'm going to have to look for alternatives when I have the time.


# WHAT IS IT?

A docker container which allows for two separate instances of ZAP2XML using environment variables. There is also a dummy xmltv generator.

The chosen services are run every eight hours as part of a cronjob. Once they are completed XTEVE's playlists and XMLTV will be updated via an API call (API must be enabled in XTEVE's settings).

The XTEVE webui can be accessed via http://XIP:34400/web.

# COMPOSE

```
version: '3'
services:
  xmltvgrabber:
    container_name: xmltvgrabber
    image: ghcr.io/colino17/xmltvgrabber-docker:latest
    restart: unless-stopped
    volumes:
      - /path/to/xmltv:/xmltv
      - /path/to/extras:/extras
    environment:
      ### Primary ZAP2XML instance
      - Z1=true
      - ZUSER1=username
      - ZPASS1=password
      - ZXML1=zap1.xml
      - ZARG1=
      ### Secondary ZAP2XML instance
      - Z2=true
      - ZUSER2=username
      - ZPASS2=password
      - ZXML2=zap2.xml
      - ZARG2=
      ### XTEVE API information
      - XTEVE=true
      - XIP=local ip address
      - XPORT=34400
      ### DUMMY XMLTV instance
      - DUMMY=true
```

# CREDITS AND SOURCES
- https://github.com/shuaiscott/zap2xml
- https://github.com/yurividal/dummyepgxml
