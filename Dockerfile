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
ENV XTEVE=true
ENV XIP=
ENV XPORT=34400
ENV DUMMY=false
ENV TZ=Canada/Atlantic

# BASICS
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates coreutils shadow gnutls-utils curl bash busybox-suid su-exec tzdata

# ZAP2XML
RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "@edgetesting http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache perl@edge perl-html-parser@edge perl-http-cookies@edge perl-lwp-useragent-determined@edge perl-json@edge perl-json-xs@edge
RUN apk add --no-cache perl-lwp-protocol-https@edge perl-uri@edge ca-certificates@edge perl-net-libidn@edge perl-net-ssleay@edge perl-io-socket-ssl@edge perl-libwww@edge perl-mozilla-ca@edge perl-net-http@edge
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
