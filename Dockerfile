FROM golang

RUN apt-get update && \
    apt-get install -y sudo btrfs-tools libbtrfs-dev libseccomp-dev socat


RUN mkdir -p /go/src/github.com/containerd
WORKDIR /go/src/github.com/containerd

# get the last release version
RUN wget https://github.com/containerd/cri/archive/release/1.3.zip
RUN unzip 1.3.zip
RUN mv cri-release-1.3 cri
WORKDIR /go/src/github.com/containerd/cri

# Build
RUN make clean
RUN make install.deps
RUN make
RUN ls _output
