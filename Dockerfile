FROM ringcentral/node:12.18.2-jdk8u202
LABEL maintainer="john.lin@ringcentral.com"

ADD ./libs/*.zip /tmp/

ARG INSTANTCLIENT_VERSION=12.2.0.1.0

RUN apk update && apk upgrade \
  && apk add --no-cache alpine-sdk python2 unzip git libaio libnsl

RUN LIBS="*/libclntsh.so.12.1 */libclntshcore.so.12.1 */libipc1.so */libmql1.so */libnnz12.so */libocci.so.12.1 */libociicus.so */libocijdbc12.so */libons.so */liboramysql12.so */ojdbc8.jar */uidrvci */adrci */genezi */xstreams.jar" \
  && unzip /tmp/instantclient-basiclite-linux.x64-${INSTANTCLIENT_VERSION}.zip ${LIBS} \
  && for lib in ${LIBS}; do mv ${lib} /usr/lib; done \
  && ln -s /usr/lib/libclntsh.so.12.1 /usr/lib/libclntsh.so \
  && ln -s /usr/lib/libocci.so.12.1 /usr/lib/libocci.so \
  && ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 \
  && ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2 \
  && ln -s /lib64/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2 \
  && rm -f /tmp/instantclient*
