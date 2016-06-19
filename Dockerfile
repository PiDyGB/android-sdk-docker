FROM ubuntu:16.04
MAINTAINER Giuseppe Buzzanca <giuseppebuzzanca@gmail.com>

# Working dir
WORKDIR /opt

# Dowload SDK
ADD https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz /opt

# Add environment variables
ENV ANDROID_SDK_FILE="android-sdk_r24.4.1-linux.tgz" \
    ANDROID_SDK_FILTER="1,2,3,27,139,146,147,148,149,150"

ENV PATH /opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:$PATH
ENV ANDROID_HOME /opt/android-sdk-linux

# Update the system
RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get -y install openjdk-8-jdk lib32z1 lib32ncurses5 lib32stdc++6 git && \
    tar xzf ${ANDROID_SDK_FILE} && \
    echo y | android update sdk --no-ui --all --filter ${ANDROID_SDK_FILTER}

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -f ${ANDROID_SDK_FILE} && \
    apt-get autoremove -y && \
    apt-get clean

WORKDIR ~/

