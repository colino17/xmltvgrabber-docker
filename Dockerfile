FROM alpine:latest

# ENVIRONMENT
ENV TZ=Canada/Atlantic

# BASICS
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates coreutils shadow gnutls-utils curl bash busybox-suid su-exec tzdata

RUN mkdir /xmltv

# DUMMY XMLTV
ADD dummy /dummy

# TIMEZONE
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# VOLUMES
VOLUME /extras
VOLUME /xmltv

# CRON
ADD scripts scripts/
ADD crontab /
RUN crontab crontab

# PERMISSIONS
RUN chmod +x /dummy/dummyxmltv.sh
RUN chmod +x /scripts/xml.sh

# CMD
CMD ["crond", "-f"]
