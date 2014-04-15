FROM ubuntu:quantal
MAINTAINER kh0r "kh0r@mklepp.com"

RUN	apt-get update && \
	apt-get install -y -q wget curl && \
	apt-get install -y -q build-essential cmake && \
	curl -L 'http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.7/opencv-2.4.7.tar.gz/' | tar xvzf - && \
	mkdir -p opencv-2.4.7/release && \
	cd opencv-2.4.7/release && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
	make && make install && \
	cd / && rm -rf opencv-2.4.7

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean
