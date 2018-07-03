FROM base/archlinux:2018.06.01
SHELL ["/bin/bash", "-lc"]
RUN pacman -Syu --noconfirm && pacman -S --noconfirm jdk8-openjdk wget git openssh tar gzip unzip ca-certificates base-devel gradle gcc clang cmake sfml python xorg xorg-server xorg-apps xorg-server-xvfb

RUN wget https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz && tar -xzf cmake-3.7.2-Linux-x86_64.tar.gz -C /var/opt && rm cmake-3.7.2-Linux-x86_64.tar.gz

RUN mkdir /var/opt/android-sdk-linux
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && unzip sdk-tools-linux-4333796.zip -d /var/opt/android-sdk-linux && rm sdk-tools-linux-4333796.zip
ENV ANDROID_HOME /var/opt/android-sdk-linux
ENV ANDROID_NDK_HOME /var/opt/android-sdk-linux/ndk-bundle
RUN yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;28.0.1" "platform-tools" "platforms;android-17" "ndk-bundle"

RUN Xvfb :100 -screen 0 640x480x24 -fbdir /var/tmp& 
