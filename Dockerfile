FROM python:3-stretch

# Install Dependencies for tesseract
RUN apt-get update && apt-get install -y \
    g++ \
    autoconf \
    automake \
    libtool \
    autoconf-archive \
    pkg-config \
    libpng-dev \
    libjpeg62-turbo-dev \
    libtiff5-dev zlib1g-dev \
    libleptonica-dev
RUN wget https://github.com/tesseract-ocr/tesseract/archive/4.00.00dev.tar.gz && \
    tar xvf 4.00.00dev.tar.gz && \
    rm -rf 4.00.00dev.tar.gz

WORKDIR tesseract-4.00.00dev/
RUN ./autogen.sh && \
    ./configure && \
    LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make && \
    make install && \
    ldconfig

WORKDIR /home

# Cleanup
RUN rm -rf tesseract/4.00.00dev/

RUN tesseract -v
