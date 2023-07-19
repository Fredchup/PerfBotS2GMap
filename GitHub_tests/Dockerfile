# Multi-container Dockerfile for build and run containers for vg

# Use Google's non-rate-limited mirror of Docker Hub to get our base image.
# This helps automated Quay builds because Quay hasn't built a caching system
# and exposes pull rate limits to users.
FROM mirror.gcr.io/library/ubuntu:20.04 AS base
MAINTAINER vgteam

RUN echo base > /stage.txt

WORKDIR /vg

# Prevent dpkg from trying to ask any questions, ever
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

FROM base AS build
ARG THREADS=8
ARG TARGETARCH

RUN echo build > /stage.txt

RUN http_proxy=http://proxy.ethz.ch:3128 apt-get -qq -y update && \
    http_proxy=http://proxy.ethz.ch:3128 apt-get -qq -y upgrade && \
    http_proxy=http://proxy.ethz.ch:3128 apt-get -qq -y install sudo

# Install all vg's dependencies.
# The Makefile will come parse the Dockerfile to get the correct dependencies;
# this is the One True Depencency List.
# We don't need to clean the package index since we don't ship this image and
# don't care about its size.
# We clip out everything between these begin and end markers, except the line
# that starts with RUN, or comments. And we pull out line continuation slashes.
# TODO: can we read them here and in the Makefile from the README instead?
###DEPS_BEGIN###
RUN http_proxy=http://proxy.ethz.ch:3128 apt-get -qq -y update && http_proxy=http://proxy.ethz.ch:3128 apt-get -qq -y upgrade && http_proxy=http://proxy.ethz.ch:3128 apt-get -qq -y install \
    make git build-essential protobuf-compiler libprotoc-dev libjansson-dev libbz2-dev \
    libncurses5-dev automake gettext autopoint libtool jq bsdmainutils bc rs parallel npm \
    samtools curl unzip redland-utils librdf-dev cmake pkg-config wget gtk-doc-tools \
    raptor2-utils rasqal-utils bison flex gawk libgoogle-perftools-dev liblz4-dev liblzma-dev \
    libcairo2-dev libpixman-1-dev libffi-dev libcairo-dev libprotobuf-dev libboost-all-dev \
    tabix bcftools libzstd-dev pybind11-dev python3-pybind11
###DEPS_END###

# Prepare to build submodule dependencies
COPY source_me.sh /vg/source_me.sh
COPY deps /vg/deps
# To increase portability of the docker image, when building for amd64, set the
# target CPU architecture to Nehalem (2008) rather than auto-detecting the
# build machine's CPU. This has no AVX1, AVX2, or PCLMUL, but it does have
# SSE4.2. UCSC has a Nehalem machine that we want to support.
RUN if [ -z "${TARGETARCH}" ] || [ "${TARGETARCH}" = "amd64" ] ; then sed -i s/march=native/march=nehalem/ deps/sdsl-lite/CMakeLists.txt; fi
# Clear any CMake caches in case we are building from someone's checkout
RUN find . -name CMakeCache.txt | xargs rm -f
# Build the dependencies
COPY Makefile /vg/Makefile
RUN . ./source_me.sh && CXXFLAGS="$(if [ -z "${TARGETARCH}" ] || [ "${TARGETARCH}" = "amd64" ] ; then echo " -march=nehalem "; fi)" CFLAGS="$(if [ -z "${TARGETARCH}" ] || [ "${TARGETARCH}" = "amd64" ] ; then echo " -march=nehalem "; fi)" make -j $((THREADS < $(nproc) ? THREADS : $(nproc))) deps

# Bring in the sources, which we need in order to build
COPY src /vg/src
COPY test /vg/test
COPY chr20_HG001_002_003_004_005_006_007_v3.3.2_chopped.vg /vg/chr20_HG001_002_003_004_005_006_007_v3.3.2_chopped.vg

RUN http_proxy=http://proxy.ethz.ch:3128 apt-get install nano
RUN mkdir wor_files && mkdir out_files
COPY test_scripts /vg/test_scripts
