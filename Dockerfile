FROM archlinux/base:latest
SHELL ["/bin/bash", "-lc"]
RUN useradd -m test
RUN pacman -Syu --noconfirm && pacman -S --noconfirm jdk8-openjdk wget git openssh tar gzip unzip ca-certificates base-devel gradle gcc clang cmake ninja sfml python xorg xorg-server xorg-apps xorg-server-xvfb

RUN mkdir /var/opt/cmake
RUN wget https://cmake.org/files/v3.13/cmake-3.13.2-Linux-x86_64.tar.gz && tar -xzf cmake-3.13.2-Linux-x86_64.tar.gz --strip=1 -C /var/opt/cmake && rm cmake-3.13.2-Linux-x86_64.tar.gz
ENV ANDROID_CMAKE=/var/opt/cmake

RUN mkdir -p /var/opt/android-sdk-linux/cmdline-tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip && unzip commandlinetools-linux-6609375_latest.zip -d /var/opt/android-sdk-linux/cmdline-tools && rm commandlinetools-linux-6609375_latest.zip
ENV ANDROID_HOME /var/opt/android-sdk-linux
ENV ANDROID_NDK_HOME /var/opt/android-sdk-linux/ndk-bundle
RUN yes | $ANDROID_HOME/cmdline-tools/tools/bin/sdkmanager --licenses
RUN $ANDROID_HOME/cmdline-tools/tools/bin/sdkmanager "build-tools;29.0.2" "platform-tools" "platforms;android-29" "ndk-bundle"

RUN Xvfb :100 -screen 0 640x480x24 -fbdir /var/tmp& 
