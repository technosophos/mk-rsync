FROM debian:8-slim

RUN apt-get update \
  && apt-get install -y rsync \
  && rm -rf /var/lib/apt/lists/*

COPY sync.sh /usr/local/bin

CMD /usr/local/bin/sync.sh
