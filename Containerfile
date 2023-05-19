FROM registry.fedoraproject.org/fedora:38

COPY files/bashrc /root/.bashrc

RUN dnf update -y &&\
    dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm &&\
    dnf install -y autoconf ccache clang cmake ffmpeg-devel fmt-devel gcc gcc-c++ git glslang hidapi-devel json-devel libtool libusb1-devel libXext-devel libzstd-devel lz4-devel nasm ninja-build openssl-devel pulseaudio-libs-devel qt5-linguist qt5-qtbase-devel qt5-qtbase-private-devel qt5-qtmultimedia-devel qt5-qtwebengine-devel rsync SDL2-devel speexdsp-devel vim-enhanced wayland-devel wget zip zlib-devel &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    echo 'defaultyes=True' >> /etc/dnf/dnf.conf &&\
    mkdir /root/.bashrc.d

# set login directory
WORKDIR /root

CMD ["/bin/bash"]
