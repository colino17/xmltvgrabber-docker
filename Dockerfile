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
ENV XTEVE=false
ENV XIP=
ENV XPORT=34400
ENV DUMMY=false
ENV TZ=Canada/Atlantic

# BASICS
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates coreutils shadow gnutls-utils curl bash busybox-suid su-exec tzdata

# ZAP2XML
RUN apk add --no-cache perl perl-html-parser perl-http-cookies perl-lwp-useragent-determined perl-json perl-json-xs perl-lwp-protocol-https perl-uri ca-certificates perl-net-libidn perl-net-ssleay perl-io-socket-ssl perl-libwww perl-mozilla-ca perl-net-http
ADD zap2xml.pl /
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
RUN chmod +x /zap2xml.pl

# CMD
CMD ["crond", "-f"]
