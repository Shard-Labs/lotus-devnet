FROM ubuntu:18.04

WORKDIR /

RUN apt-get update && \
    apt-get install -y \
     mesa-opencl-icd ocl-icd-opencl-dev software-properties-common

RUN add-apt-repository ppa:longsleep/golang-backports && \
    apt-get update && \
    apt-get install -y \
     golang-go gcc git bzr jq pkg-config mesa-opencl-icd ocl-icd-opencl-dev

RUN git clone https://github.com/filecoin-project/lotus.git

WORKDIR /lotus
RUN apt-get install -y curl
RUN make debug
RUN ./lotus fetch-params --proving-params 1024
RUN ./lotus-seed pre-seal --sector-size 1024 --num-sectors 2
COPY ./script.sh /lotus/script.sh
COPY ./.lotus /lotusTemp
ENTRYPOINT ["sh", "script.sh"]