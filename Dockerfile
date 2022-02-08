FROM balenalib/rpi-raspbian:bullseye AS builder

WORKDIR /usr/src/app
# make folder readable by other users -> _apt can't access some deb files otherwise
RUN chmod 777 /usr/src/app

RUN mkdir -p /usr/src/debian-rootfs 

# RUN install_packages build-essential 

# list of packages to be installed in rootfs we will use in next stage
ARG PACKAGES="libraspberrypi-bin"

# download all packages and dependencies
RUN apt update && apt-get download $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances ${PACKAGES} | grep "^\w" | sort -u)

# install packages to separate rootfs
RUN for pkg in *.deb; \
      do dpkg-deb  -x $pkg /usr/src/debian-rootfs; \
      done


FROM busybox:stable

COPY --from=builder /usr/src/debian-rootfs ./

