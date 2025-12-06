ARG KAIROS_BASE_IMAGE=quay.io/kairos/ubuntu:22.04-standard-amd64-generic-v3.6.0-k3s-v1.32.9-k3s1

FROM ${KAIROS_BASE_IMAGE}

# Install WireGuard and wireguard-tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wireguard \
    wireguard-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
