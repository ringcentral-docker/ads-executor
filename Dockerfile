FROM ringcentral/node:10.16.0-jdk8u202
LABEL maintainer="john.lin@ringcentral.com"

ADD ./libs/*.zip /tmp/
ARG INSTANTCLIENT_VERSION=12.2.0.1.0

RUN apk update && apk upgrade \
  && apk add --no-cache alpine-sdk python unzip git \
  && mkdir /opt/oracle \
  && unzip /tmp/instantclient-basiclite-linux.x64-${INSTANTCLIENT_VERSION}.zip \
  && unzip /tmp/instantclient-sdk-linux.x64-${INSTANTCLIENT_VERSION}.zip \
  && mv instantclient_12_2 /opt/oracle/instantclient \
  && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so \
  && export LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH \
  && export OCI_LIB_DIR=/opt/oracle/instantclient \
  && export OCI_INC_DIR=/opt/oracle/instantclient/sdk/include