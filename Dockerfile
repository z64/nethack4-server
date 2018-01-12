from debian:jessie-slim

# Install dependencies
RUN apt-get update \
 && apt-get --yes install \
    wget \
    libperl4-corelibs-perl \
    flex \
    bison \
    libpq-dev \
    zlib1g-dev \
    build-essential

# Download and extract source
RUN wget http://nethack4.org./media/releases/nethack4-4.3-beta2.tar.gz -O /tmp/nethack4.tar.gz \
 && tar -xvf /tmp/nethack4.tar.gz -C /tmp
WORKDIR /tmp/nethack4-4.3-beta2

# Build server
RUN useradd -m nethack
RUN chmod +x ./aimake
RUN mkdir /opt/nethack4 \
 && chown nethack /opt/nethack4

USER nethack
RUN mkdir build \
 && mkdir install \
 && cd build \
 && ../aimake -i ../install \
    --with=server \
    --with=jansson \
    --without=gui \
    --without=slashem_tiles \
    --without=dawnlike_tiles \
    --without=rltiles_tiles \
    --v \
    ; exit 0
