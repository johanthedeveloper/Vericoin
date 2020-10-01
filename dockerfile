FROM ubuntu:18.04 AS base

# Install needed software
RUN apt update -y && apt upgrade -y
RUN apt-get install -y nano git unzip zip wget 
RUN apt-get install -y build-essential libboost-all-dev libssl1.0-dev libdb++-dev 
RUN apt-get install -y libminiupnpc-dev libcurl4-gnutls-dev libminizip-dev

# Copy scripts files
WORKDIR /usr/libexec/
COPY ./scripts/ ./vericoin/
RUN find ./vericoin/ -type f -iname "*.sh" -exec chmod +x {} \;

##############################################
### Starting new container for building
FROM base AS build

# Git Clone
RUN git clone -v https://github.com/vericoin/vericoin.git /root/git/vericoin/

#Set new work directory for building vericoin
WORKDIR /root/git/vericoin/src/

# Build vericoin
#RUN echo "$PWD" && cd /root/git/vericoin/src/ && echo "$PWD"
#RUN echo "$PWD" && rm /root/git/vericoin/src/main.cpp && echo "$PWD"
RUN rm main.cpp
COPY ["code/main.cpp", "."]
RUN rm makefile.unix
COPY ["code/makefile.unix", "."]
RUN make -f makefile.unix
RUN mkdir -p /app/publish
RUN cp vericoind /app/publish

##############################################
### Starting new container for publish
FROM base AS publish

#copy from build
COPY --from=build /app/publish /usr/bin/

# Add entrypoint
ENTRYPOINT ["/usr/libexec/vericoin/startup.sh"]
