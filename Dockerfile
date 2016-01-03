FROM index.alauda.cn/tutum/centos:6.5
MAINTAINER Gude  <zgdgude@gmail.com>
RUN yum update -y
RUN yum install m2crypto git libsodium -y
#add chacha20
RUN wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz && \
    tar zxf LATEST.tar.gz && \
    cd libsodium* && \
    ./configure && make -j2 && make install && \
    ldconfig
RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git && \
    cd shadowsocks/shadowsocks
ENV SS_PASSWORD password
ENV SS_METHOD chacha20
ENV SS_PORT 50400
ENV SS_PROTOCOL=auth_sha1
ENV_OBFS=tls1.0_session_auth
EXPOSE $SS_PORT
ENTRYPOINT python server.py -p $SS_PORT -k $SS_PASSWORD -m $SS_METHOD -o $ENV_OBFS -P $SS_PROTOCOL -d start
