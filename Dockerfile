FROM ringcentral/node:12.18.2-jdk8u202
LABEL maintainer="john.lin@ringcentral.com"

ADD ./libs/*.zip /tmp/

ENV ORACLE_HOME=/opt/oracle/instantclient
ENV ORACLE_BASE=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
ENV TNS_ADMIN=/opt/oracle/instantclient
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INC_DIR=/opt/oracle/instantclient/sdk/include

ARG INSTANTCLIENT_VERSION=12.2.0.1.0

RUN apk update && apk upgrade \
  && apk add --no-cache alpine-sdk python2 unzip git \
  && mkdir /opt/oracle \
  && unzip /tmp/instantclient-basiclite-linux.x64-${INSTANTCLIENT_VERSION}.zip \
  && unzip /tmp/instantclient-sdk-linux.x64-${INSTANTCLIENT_VERSION}.zip \
  && mv instantclient_12_2 /opt/oracle/instantclient \
  && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /usr/lib/libclntsh.so \
  && ln -s /opt/oracle/instantclient/libocci.so.12.1 /usr/lib/libocci.so \
  && ln -s /opt/oracle/instantclient/libociicus.so /usr/lib/libociicus.so \
  && ln -s /opt/oracle/instantclient/libnnz12.so /usr/lib/libnnz12.so \
  && ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 \
  && ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2 \
  && ln -s /lib64/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2
