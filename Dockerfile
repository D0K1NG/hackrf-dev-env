FROM ubuntu:24.04

RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    cmake \
    libusb-1.0-0-dev \
    pkg-config \
    libfftw3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]