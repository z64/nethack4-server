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
    build-essential \
    socat

# Setup user and folder
RUN useradd nethack
RUN mkdir /opt/nethack4

# Download and extract source
RUN wget http://nethack4.org./media/releases/nethack4-4.3-beta2.tar.gz -O /tmp/nethack4.tar.gz \
 && tar -xvf /tmp/nethack4.tar.gz -C /opt/nethack4 --strip-components=1

# Build executables
RUN chown nethack /opt/nethack4
WORKDIR /opt/nethack4
USER nethack
RUN mkdir build \
 && mkdir bin \
 && cd build \
 && ../aimake -i ../bin \
    --with=server \
    --with=jansson \
    --without=gui \
    --without=slashem_tiles \
    --without=dawnlike_tiles \
    --without=rltiles_tiles \
    --v \
    ; exit 0

COPY ./nethack4.conf /opt/nethack4/bin/
USER root

EXPOSE 53430

ENTRYPOINT ["socat", "TCP4-LISTEN:53430,fork", "EXEC:'/opt/nethack4/bin/nethack4-server -c /opt/nethack4/bin/nethack4.conf'"]
