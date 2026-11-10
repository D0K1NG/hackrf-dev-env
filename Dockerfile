FROM ubuntu:24.04

RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    cmake \
    libusb-1.0-0-dev \
    pkg-config \
    libfftw3-dev \
    gcc-arm-none-eabi \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# Hackrf lib download config:
ARG HACKRF_REF=main
RUN git clone --depth 1 --branch "${HACKRF_REF}" \
    https://github.com/greatscottgadgets/hackrf.git /tmp/hackrf \
    && cmake -S /tmp/hackrf/host/libhackrf -B /tmp/libhackrf-build \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    && cmake --build /tmp/libhackrf-build --parallel \
    && cmake --install /tmp/libhackrf-build \
    && ldconfig \
    && rm -rf /tmp/hackrf /tmp/libhackrf-build


ENV CC=gcc \
    ARM_CC=arm-none-eabi-gcc

WORKDIR /workspace
CMD ["bash"]