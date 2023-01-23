FROM alpine:latest

# ENVIRONMENT
ENV Z1=false
ENV ZUSER1=none
ENV ZPASS1=none
ENV Z2=false
ENV ZUSER2=none
ENV ZPASS2=none
ENV ZXML1=zap1.xml
ENV ZXML2=zap2.xml
ENV ZARG1=
ENV ZARG2=
ENV XIP=
ENV XPORT=34400
ENV USTV=true
ENV DUMMY=false
ENV TZ=Canada/Atlantic

# BASICS
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates coreutils shadow gnutls-utils curl bash busybox-suid su-exec tzdata xmltv perl-datetime-format-strptime

# DUMMY XMLTV
ADD dummy /dummy
ADD extras /

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
RUN chmod +x /dummy/xml.sh

# CMD
CMD ["crond", "-f"]
