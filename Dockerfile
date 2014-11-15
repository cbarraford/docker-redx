FROM ubuntu:latest
MAINTAINER Chad Barraford <chad@rstudio.com>

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Update apt
RUN apt-get -y -qq update
RUN apt-get install -y build-essential curl libreadline-dev libncurses5-dev libpcre3-dev libssl-dev lua5.2 luarocks perl wget git openssl

# Compile openresty from source.
RUN \
  wget http://openresty.org/download/ngx_openresty-1.7.2.1.tar.gz && \
  tar -xzvf ngx_openresty-*.tar.gz && \
  rm -f ngx_openresty-*.tar.gz && \
  cd ngx_openresty-* && \
  ./configure --with-pcre-jit --with-ipv6 && \
  make && \
  make install && \
  make clean && \
  cd .. && \
  rm -rf ngx_openresty-*&& \
  ln -s /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx && \
  ldconfig

# Install luarocks modules
RUN luarocks install luasec 0.4-4 OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu
RUN luarocks install lua-cjson 2.1.0-1
RUN luarocks install busted 1.9.0-1
RUN luarocks install lapis 1.0.4-1
RUN luarocks install moonscript 0.2.4-1
RUN luarocks install inspect 1.2-2

# copy redx nginx file
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

# install redx
RUN git clone https://github.com/rstudio/redx.git /opt/redx

# create redx config file
ADD configure.bash .
ADD entrypoint.bash .

# expose ports
EXPOSE 80 443 8081 8082

# Set the entry point script
ENTRYPOINT ["./entrypoint.bash"]

# Define the default command.
CMD ["nginx", "-c", "conf/nginx.conf"]
