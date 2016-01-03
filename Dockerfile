FROM centos:6.6
MAINTAINER Gude  <zgdgude@gmail.com>
RUN yum update -y
RUN yum install m2crypto git libsodium wget tar gcc -y
#add chacha20
RUN wget https://github.com/jedisct1/libsodium/releases/download/1.0.7/libsodium-1.0.7.tar.gz && \
    tar xf libsodium-1.0.7.tar.gz && cd libsodium-1.0.7 && \
    ./configure && make -j2 && make install && \
    ldconfig
RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git
ENV SS_PASSWORD password
ENV SS_METHOD chacha20
ENV SS_PORT 50400
ENV SS_PROTOCOL auth_sha1
ENV SS_OBFS tls1.0_session_auth
EXPOSE $SS_PORT
CMD cd shadowsocks/shadowsocks&&python server.py -p $SS_PORT -k $SS_PASSWORD -m $SS_METHOD -o $SS_OBFS -P $SS_PROTOCOL -d start
