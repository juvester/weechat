FROM ubuntu

RUN apt-get update && apt-get -y install \
    git \
    cmake \
    pkg-config \
    libncursesw5-dev \
    libcurl4-gnutls-dev \
    zlib1g-dev \
    libgcrypt20-dev

RUN useradd -g users user && \
    mkdir -p /home/user && \
    chown -R user:users /home/user
USER user
WORKDIR /home/user

RUN git clone --depth=1 --branch v2.6 https://github.com/juvester/weechat.git
RUN mkdir /home/user/weechat/build
WORKDIR /home/user/weechat/build

RUN cmake -DCMAKE_INSTALL_PREFIX=/home/user/.local ..
RUN make -j4
RUN make install

CMD ["/home/user/.local/bin/weechat"]
