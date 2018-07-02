FROM base/archlinux:2018.06.01
USER test
RUN pacman -Syu --noconfirm && pacman -S --noconfirm git openssh tar gzip unzip ca-certificates base-devel gradle gcc clang cmake sfml python xorg xorg-server xorg-apps xorg-server-xvfb
RUN cd ~/ && wget https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz && tar -xzf ./cmake-3.7.2-Linux-x86_64.tar.gz
RUN mkdir -p android/android-sdk-linux cd android/android-sdk-linux
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && unzip ./sdk-tools-linux-4333796.zip
RUN yes | ./tools/bin/sdkmanager "build-tools;28.0.1" "platform-tools" "platforms;android-17" "ndk-bundle"
RUN echo -n "ANDROID_HOME=~/android/android-sdk-linux"
RUN echo -n "ANDROID_NDK_HOME=~/android/android-sdk-linux/ndk-bundle"
RUN Xvfb :100 -screen 0 640x480x24 -fbdir /var/tmp& 
