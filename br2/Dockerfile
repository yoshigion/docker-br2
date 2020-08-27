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

# Change default shell to bash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# Add packages for buildroot itself
RUN apt-get install -y sed make binutils build-essential gcc g++ bash patch gzip bzip2 perl tar cpio unzip rsync file bc wget
RUN apt-get install -y libncurses5 git
RUN apt-get install -y python-is-python3
RUN apt-get install -y graphviz python3-matplotlib

# Add packages for target build
RUN apt-get install -y device-tree-compiler libssl-dev gettext bison flex unifdef

# Add utilitie packages
RUN apt-get install -y sudo vim

# Install Buildroot
ENV RELEASE_BR2 "2020.02"
ENV WORKING_DIR_BR2=/working-br2
RUN set -x \
&& mkdir -p ${WORKING_DIR_BR2} \
&& chmod 777 ${WORKING_DIR_BR2} \
&& echo "Downloading and extracting buildroot ${RELEASE_BR2}" \
&& wget -q -c http://buildroot.org/downloads/buildroot-${RELEASE_BR2}.tar.gz \
&& tar axf buildroot-${RELEASE_BR2}.tar.gz -C ${WORKING_DIR_BR2} \
&& mv ${WORKING_DIR_BR2}/buildroot-${RELEASE_BR2} ${WORKING_DIR_BR2}/buildroot \
&& chmod -R a+w ${WORKING_DIR_BR2}/buildroot
RUN set -x \
&& rm buildroot-${RELEASE_BR2}.tar.gz

# Setup build user environment
ENV BUILD_DIR_BR2=${WORKING_DIR_BR2}
ENV LOG_DIR_BR2=${WORKING_DIR_BR2}/log
ENV IMAGE_DIR_BR2=/br2-output
RUN set -x \
&& echo "${BUILD_DIR_BR2}"

RUN set -x \
&& mkdir -p ${BUILD_DIR_BR2} ${LOG_DIR_BR2} ${IMAGE_DIR_BR2} \
&& chmod 777 ${BUILD_DIR_BR2} ${LOG_DIR_BR2} ${IMAGE_DIR_BR2}

ENV DOCKER_UID=10000
ENV DOCKER_GID=10000
ENV DOCKER_UNAME=docker
ENV DOCKER_GROUP=docker
ENV DOCKER_PASSWORD=docker
RUN set -x \
&& echo "%"${DOCKER_GROUP}" ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${DOCKER_GROUP}

RUN set -x \
&& useradd -m --uid ${DOCKER_UID} ${DOCKER_UNAME} \
&& echo ${DOCKER_UNAME}:${DOCKER_PASSWORD} | chpasswd

WORKDIR ${WORKING_DIR_BR2}

COPY ./setup.sh ${WORKING_DIR_BR2}/setup.sh
COPY ./build.sh ${WORKING_DIR_BR2}/build.sh
COPY ./entry.sh ${WORKING_DIR_BR2}/entry.sh
RUN set -x \
&& chmod 777 ${WORKING_DIR_BR2}/setup.sh ${WORKING_DIR_BR2}/build.sh ${WORKING_DIR_BR2}/entry.sh

# DEFCONFIG_BR2 is provided by external environment
COPY ./${DEFCONFIG_BR2} ${WORKING_DIR_BR2}/
RUN set -x \
&& chmod a+r ${WORKING_DIR_BR2}/${DEFCONFIG_BR2}

USER ${DOCKER_UNAME}
