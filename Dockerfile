FROM golang

RUN apt-get update && \
    apt-get install -y sudo btrfs-tools libbtrfs-dev libseccomp-dev socat


#RUN go get github.com/containerd/cri
#WORKDIR /go/src/github.com/containerd/cri

# I used wget rather than `go get` to avoid proxy issue in my office
RUN mkdir -p /go/src/github.com/containerd
WORKDIR /go/src/github.com/containerd

# get the last release version
RUN wget https://github.com/containerd/cri/archive/v1.11.1.tar.gz
RUN tar xvf v1.11.1.tar.gz
RUN mv cri-1.11.1 cri
WORKDIR /go/src/github.com/containerd/cri

# copy modified file
COPY container_create.go /go/src/github.com/containerd/cri/pkg/server/container_create.go

# Build
RUN make clean
RUN make install.deps
RUN make
RUN ls _output