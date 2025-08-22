
# ============================================================================
# Dockerfile for building a MXE (Mingw-w64 Cross Environment) image
# ============================================================================
# This Dockerfile builds a Debian-based image with MXE installed, allowing for
# cross-compilation of Windows binaries.

FROM debian:testing-20250317 AS build

# Define arguments for the build process
ARG MXE_TARGET=x86_64-w64-mingw32.static
ARG MXE_PKG=mxe-x86-64-w64-mingw32.shared

# Set the working directory
WORKDIR /opt/mxe-w64/

# Install dependencies required for MXE and cross-compilation
RUN apt-get update && \
 apt-get install -y \
 autoconf \
 automake \
 autopoint \
 bash \
 bison \
 bzip2 \
 flex \
 g++ \
 g++-multilib \
 gettext \
 git \
 gperf \
 intltool \
 libc6-dev-i386 \
 libgdk-pixbuf-xlib-2.0-dev \
 libltdl-dev \
 libgl-dev \
 libssl-dev \
 libtool-bin \
 libxml-parser-perl \
 lzip \
 make \
 openssl \
 p7zip-full \
 patch \
 perl \
 python3 \
 python3-distutils-extra \
 python3-mako \
 python3-pip \
 python3-pkg-resources \
 python-is-python3 \
 ruby \
 scons \
 sed \
 unzip \
 wget \
 xz-utils

# Install MXE and build required packages
RUN git clone --depth 1 https://github.com/mxe/mxe/ . && \
 make boost libftdi1 zlib cmake cmake-conf ninja pkgconf \
 MXE_USE_CCACHE= MXE_TARGETS='x86_64-w64-mingw32.static' && \
 rm logs .ccache pkg -rf

ENV CMAKE_MODULE_PATH=/opt/mxe-w64/usr/x86_64-pc-linux-gnu/share/cmake-3.31/Modules/
ENV Boost_DIR=/opt/mxe-w64/usr/x86_64-w64-mingw32.static/lib/cmake/Boost-1.85.0/
ENV PKG_CONFIG_PATH=/opt/mxe-w64/usr/x86_64-w64-mingw32.static/lib/pkgconfig/
ENV PATH="${PATH}:/opt/mxe-w64/usr/bin"

RUN ln -s /opt/mxe-w64/usr/bin/x86_64-w64-mingw32.static-cmake /usr/bin/cmake
