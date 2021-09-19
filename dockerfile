FROM ubuntu:20.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Install needed software
RUN apt update -y && apt upgrade -y
RUN apt-get install -y git build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libcurl4-openssl-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libminizip-dev zlib1g-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev wget libboost-all-dev

# Copy scripts files
WORKDIR /usr/libexec/
COPY ./scripts/ ./vericoin/
RUN find ./vericoin/ -type f -iname "*.sh" -exec chmod +x {} \;

##############################################
### Starting new container for building
FROM base AS build

# Git Clone
RUN git clone https://github.com/VeriConomy/vericoin.git ~/vericoin

#Set new work directory for building vericoin
WORKDIR ~/vericoin

# Build vericoin
#RUN echo "$PWD" && cd /root/git/vericoin/src/ && echo "$PWD"
#RUN echo "$PWD" && rm /root/git/vericoin/src/main.cpp && echo "$PWD"
#RUN rm main.cpp
#COPY ["code/main.cpp", "."]
#RUN rm makefile.unix
#COPY ["code/makefile.unix", "."]
#RUN make -f makefile.unix
#RUN mkdir -p /app/publish

RUN ./contrib/install_db4.sh ~/vericoin
RUN export BDB_PREFIX="/root/git/vericoin/db4"
ENV BDB_PREFIX="${HOME}/vericoin/db4"
RUN ./autogen.sh
RUN ./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include"
RUN make
#RUN cp /root/git/vericoin/src/vericoind /app/publish
#RUN cp /root/git/vericoin/src/vericoin-cli /app/publish
#RUN cp /root/git/vericoin/src/vericoin-tx /app/publish
#RUN cp /root/git/vericoin/src/vericoin-wallet /app/publish
RUN cp -a /root/git/vericoin/src/. /app/publish/

##############################################
### Starting new container for publish
FROM base AS publish

#copy from build
COPY --from=build /app/publish /usr/bin/

# Add entrypoint
ENTRYPOINT ["/usr/libexec/vericoin/startup.sh"]
