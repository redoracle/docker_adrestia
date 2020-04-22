FROM debian:stable
MAINTAINER RedOracle

ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION \
      org.label-schema.name='Cardano Adrestia by Redoracle' \
      org.label-schema.description='UNOfficial Cardano Adrestia docker image' \
      org.label-schema.usage='https://www.redoracle.com/docker/' \
      org.label-schema.url='https://www.redoracle.com/' \
      org.label-schema.vendor='Red0racle S3curity' \
      org.label-schema.schema-version='1.0' \
      org.label-schema.docker.cmd='docker run -dit redoracle/docker_adrestia:latest' \
      org.label-schema.docker.cmd.devel='docker run --rm -ti redoracle/docker_adrestia:latest' \
      org.label-schema.docker.debug='docker logs $CONTAINER' \
      io.github.offensive-security.docker.dockerfile="Dockerfile" \
      io.github.offensive-security.license="GPLv3" \
      MAINTAINER="RedOracle <info@redoracle.com>"
     
WORKDIR /root

VOLUME /data

COPY entrypoint.sh /

RUN set -x \
    && sed -i -e 's/^root::/root:*:/' /etc/shadow \
    && apt-get -yqq update \                                                       
    && apt-get -yqq dist-upgrade \
    && apt-get -yqq install curl grc wget busybox bash build-essential libssl-dev tmux cmake g++ pkg-config git vim-common libwebsockets-dev libjson-c-dev watch jq watch net-tools geoip-bin geoip-database \
    && cd \
    && wget https://github.com/gohugoio/hugo/releases/download/v0.68.0/hugo_extended_0.68.0_Linux-64bit.deb \
    && dpkg -i hugo_extended_0.68.0_Linux-64bit.deb \
    && chmod +x /entrypoint.sh \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
    
ENV \
DEBIAN_FRONTEND noninteractive \
LANG C.UTF-8 \
ENV=/etc/profile \
USER=root \

EXPOSE 1313

ENTRYPOINT ["/entrypoint.sh"]
