#
#  Dockerfile for buildroot
#

# Use ubuntu
FROM ubuntu:20.04

LABEL maintainer="a Buildroot Docker User <obayashi.yoshimasa@seek-the-truth.org>"

# Setup for apt-get
ENV DEBIAN_FRONTEND=noninteractive
ENV APT_PROXY_FILE_BR2="/etc/apt/apt.conf.d/02proxy"
ARG HTTP_PROXY_BR2
ARG HTTPS_PROXY_BR2
ARG no_proxy
RUN set -x \
&& ls -Rla /etc/apt/

RUN set -x && \
if [ "${HTTP_PROXY_BR2}" != "" ]; then \
  echo "Acquire::http::proxy  \"${HTTP_PROXY_BR2}\";"     >  ${APT_PROXY_FILE_BR2} && \
  if [ "${HTTPS_PROXY_BR2}" != "" ]; then \
    echo "Acquire::https::proxy \"${HTTPS_PROXY_BR2}\";"  >> ${APT_PROXY_FILE_BR2}; \
  fi  && \
  cat -A ${APT_PROXY_FILE_BR2}; \
fi

RUN set -x && \
echo "Acquire::http::Pipeline-Depth 0;" > /etc/apt/apt.conf.d/99fixadproxy && \
echo "Acquire::http::No-Cache true;"   >> /etc/apt/apt.conf.d/99fixadproxy && \
echo "Acquire::BrokenProxy true;"      >> /etc/apt/apt.conf.d/99fixadproxy && \
cat -A /etc/apt/apt.conf.d/99fixadproxy

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y apt-utils
