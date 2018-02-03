FROM debian:8-slim

RUN apt-get update \
  && apt-get install -y rsync \
  && rm -rf /var/lib/apt/lists/*

# This is the location that we will share files from. It is up to you to mount
# a volume to this path.
RUN mkdir -p /mnt/share

COPY rsyncd.conf /etc/rsyncd.conf

CMD rsync --daemon --no-detach
