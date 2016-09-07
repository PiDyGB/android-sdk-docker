FROM ubuntu:16.04
MAINTAINER Giuseppe Buzzanca <giuseppebuzzanca@gmail.com>

#Update the system
RUN apt-get update && apt-get -y dist-upgrade

#Add required software
RUN apt-get -y install openjdk-8-jdk lib32z1 lib32ncurses5 lib32stdc++6 git

# Dowload SDK
ADD https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz .

RUN tar xzf android-sdk_r24.4.1-linux.tgz -C /opt

ENV PATH=/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:$PATH
ENV ANDROID_HOME=/opt/android-sdk-linux

RUN echo y | android update sdk --no-ui --all --filter 1,3,4,30,153,160,161,162,163,164

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -f android-sdk_r24.4.1-linux.tgz && \
    apt-get autoremove -y && \
    apt-get clean
