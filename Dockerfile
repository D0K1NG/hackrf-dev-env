FROM ubuntu:24.04

# Configuration
ARG PROJECT_DIR="workspace"
ARG DEV_UID=1000
# ARG DEV_GID=1000

# Base package dependancies
RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    pkg-config \
    cmake \
    nano \
    git \
    libfftw3-dev \
    libusb-1.0-0-dev \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    libstdc++-arm-none-eabi-newlib \
    && rm -rf /var/lib/apt/lists/*

# Hackrf host API:
ARG HACKRF_REF=main
RUN git clone --depth 1 --branch "${HACKRF_REF}" \
    https://github.com/greatscottgadgets/hackrf.git /tmp/hackrf \
    && cmake -S /tmp/hackrf/host/libhackrf -B /tmp/libhackrf-build \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    && cmake --build /tmp/libhackrf-build --parallel \
    && cmake --install /tmp/libhackrf-build \
    && ldconfig \
    && rm -rf /tmp/hackrf /tmp/libhackrf-build

# Adding user for the container (configure UID/GID):
RUN if getent passwd "$DEV_UID" >/dev/null; then \
        echo "Using existing user with UID ${DEV_UID}"; \
    else \
        useradd --uid "${DEV_UID}" --create-home --shell /bin/bash dev; \
    fi

RUN mkdir -p /workspace && chown ${DEV_UID}:${DEV_UID} /${PROJECT_DIR}

USER ${DEV_UID}

# Environment variables:
ENV CC=gcc \
    ARM_CC=arm-none-eabi-gcc

WORKDIR /${PROJECT_DIR}
CMD ["bash"]