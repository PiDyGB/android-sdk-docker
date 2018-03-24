FROM ubuntu:latest
MAINTAINER Giuseppe Buzzanca <giuseppebuzzanca@gmail.com>

#Update the system
RUN apt-get update #&& apt-get -y dist-upgrade

#Add required software
RUN apt-get -y install unzip openjdk-8-jdk lib32z1 lib32ncurses5 lib32stdc++6 git

# Download SDK
ADD https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip /opt

RUN unzip /opt/sdk-tools-linux-3859397.zip -d /opt/android-sdk-linux

ENV PATH=/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:$PATH
ENV ANDROID_HOME=/opt/android-sdk-linux


#Adding /root/.android/analytics.settings to avoiding gradle exceptions
RUN mkdir -p $HOME/.android && touch $HOME/.android/analytics.settings

#Adding /root/.android/repositories.cfg
RUN mkdir -p $HOME/.android && echo "count=0" > $HOME/.android/repositories.cfg

# Adding Android License
RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -f /opt/sdk-tools-linux-3859397.zip && \
    apt-get autoremove -y && \
    apt-get clean
