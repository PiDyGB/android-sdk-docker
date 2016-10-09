FROM ubuntu:latest
MAINTAINER Giuseppe Buzzanca <giuseppebuzzanca@gmail.com>

#Update the system
RUN apt-get update && apt-get -y dist-upgrade

#Add required software
RUN apt-get -y install openjdk-8-jdk lib32z1 lib32ncurses5 lib32stdc++6 git

# Download SDK
ADD https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz /opt

RUN tar xzf /opt/android-sdk_r24.4.1-linux.tgz -C /opt

ENV PATH=/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:$PATH
ENV ANDROID_HOME=/opt/android-sdk-linux

# Adding Android License
RUN mkdir -p "$ANDROID_HOME/licenses"
RUN echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
#RUN echo y | android update sdk --no-ui --all --filter $(android list sdk --all | grep -E -v "[0-9]{1,3}.*\(Obsolete\)$" | grep -E -v "[0-9]{1,3}.*[Dd]ocumentation.*" | grep -E -v "[0-9]{1,3}.*[Ss]ystem [Ii]mage.*" | grep -E -v "[0-9]{1,3}.*[Gg]lass [Dd]evelopment [Kk]it.*" | grep -E -v "[0-9]{1,3}.*[Ss]ources.*" | grep -E -v "[0-9]{1,3}.*[Ee]mulator.*" | grep -E -v "[0-9]{1,3}.*[Ss]imulators.*" | grep -E -v "[0-9]{1,3}.*[Ww]eb [Dd]river.*" | grep -E "^ +[0-9]{1,3}" | cut -d "-" -f 1 | xargs echo | sed -e "s/ /,/g")
RUN echo y | android update sdk --no-ui --all --filter extra-google-m2repository,extra-android-m2repository

#Adding /root/.android/analytics.settings to avoiding gradle exceptions
RUN mkdir -p $HOME/.android && touch $HOME/.android/analytics.settings

#Adding /root/.android/repositories.cfg
RUN mkdir -p $HOME/.android && echo "count=0" > $HOME/.android/repositories.cfg

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -f /opt/android-sdk_r24.4.1-linux.tgz && \
    apt-get autoremove -y && \
    apt-get clean
