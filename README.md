# raspberry-pi-utils

Dockerised miscellaneous Raspberry Pi utilities from `libraspberrypi-bin`.

Image is published at [rahulthakoor/raspberry-pi-utils](https://hub.docker.com/repository/docker/rahulthakoor/raspberry-pi-utils)

## Tools included

- dtmerge
- dtoverlay
- dtoverlay-post
- dtoverlay-pre
- dtparam
- raspistill
- raspivid
- raspividyuv
- raspiyuv
- tvservice
- vcgencmd
- vcmailbox
- mmal_vc_diag
- vchiq_test

## How to use

1. Run a binary directly 

`docker run --rm -it --privileged rahulthakoor/raspberry-pi-utils vcgencmd`

2. Use as a base image

`FROM rahulthakoor/raspberry-pi-utils`

## Attribution

All credits to the original developers and maintainers of the respective utilities.