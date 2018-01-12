from debian:jessie-slim

# Install dependencies
RUN apt-get update \
 && apt-get --yes install \
    wget \
    libperl4-corelibs-perl \
    flex \
    bison \
    libghc-postgresql-libpq-dev \
    build-essential

# Download and extract source
RUN wget http://nethack4.org./media/releases/nethack4-4.3-beta2.tar.gz -O /tmp/nethack4.tar.gz \
 && tar -xvf /tmp/nethack4.tar.gz -C /tmp
WORKDIR /tmp/nethack4-4.3-beta2

# Build server
RUN adduser nethack
RUN chmod +x ./aimake
USER nethack
RUN mkdir build \
 && cd build \
 && ../aimake -i /opt/nethack4 \
    --with=server \
    --with=jansson \
    --without=gui \
    --without=slashem_tiles \
    --without=dawnlike_tiles \
    --without=rltiles_tiles \
    --v
