FROM node:16-buster-slim

WORKDIR /tmp

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y dist-upgrade \
  && apt-get install -y alien libaio1 wget apt-transport-https gnupg python3 python3-pip python3-dev git subversion mercurial sshpass bash

# set bash shell as default shell
RUN chsh -s /bin/bash \
  && rm -f /bin/sh \
  && ln -s /bin/bash /bin/sh

# install adopt openjdk 11
RUN mkdir -p /usr/share/man/man1
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add -
RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt-get update && apt-get install -y temurin-11-jdk


# maven
RUN apt-get update \
  && apt-get install -y maven

# install oracle-instantclient
RUN wget https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/getPackage/oracle-instantclient19.13-basiclite-19.13.0.0.0-2.x86_64.rpm
RUN alien -i --scripts oracle-instantclient*.rpm
RUN rm -f oracle-instantclient19*.rpm && apt-get -y autoremove && apt-get -y clean

RUN java -version \
  && node -v