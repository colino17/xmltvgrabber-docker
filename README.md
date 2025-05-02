# WHAT IS IT?

A docker container which contains a dummy xmltv generator.

The chosen services are run every eight hours as part of a cronjob.

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
```

# CREDITS AND SOURCES
- https://github.com/yurividal/dummyepgxml
