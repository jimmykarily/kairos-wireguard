# Kairos WireGuard

A custom Kairos Linux image that includes WireGuard and wireguard-tools, built on top of Kairos with k3s Kubernetes distribution.

## Overview

This repository contains a Dockerfile and GitHub Actions workflow to build a custom Kairos Linux image that extends the upstream Kairos release with WireGuard VPN support. The image is automatically built and pushed to [quay.io/jimmykarily/kairos-wireguard](https://quay.io/jimmykarily/kairos-wireguard) whenever a new tag is pushed to the repository.

## Features

- **Kairos Linux** - Immutable Linux distribution
- **k3s** - Lightweight Kubernetes distribution
- **WireGuard** - Modern VPN protocol
- **wireguard-tools** - Command-line utilities for WireGuard

## Building

The image is automatically built using GitHub Actions whenever you push a new tag to the repository. The build process uses the [Kairos Factory Action](https://github.com/kairos-io/kairos-factory-action) reusable workflow.

### Triggering a Build

To trigger a build, create and push a git tag:

```bash
git tag v1.0.0
git push origin v1.0.0
```

The workflow will automatically detect the tag and build the image. The tag name will be used as the version (with `version: auto` configured, the workflow uses git tags for versioning).

### Manual Build

To build the image manually, you can use Docker:

```bash
docker build -t kairos-wireguard .
```

You can also specify a different upstream Kairos base image:

```bash
docker build -t kairos-wireguard \
  --build-arg KAIROS_BASE_IMAGE=quay.io/kairos/ubuntu:22.04-standard-amd64-generic-v3.6.0-k3s-v1.32.9-k3s1 \
  .
```

## Usage

Once built, you can pull and use the image from Quay.io:

```bash
docker pull quay.io/jimmykarily/kairos-wireguard:<tag>
```

The image tags follow the format: `<flavor-release>-<variant>-<arch>-<model>-<version>-<kubernetes-distro>-<kubernetes-version>`

Example: `24.04-standard-amd64-generic-v3.5.2-k3s-v1.28.0`

## Dockerfile

The Dockerfile uses an upstream Kairos image as the base and adds WireGuard packages:

- Uses a pre-built Kairos image from `quay.io/kairos/ubuntu` (default: `22.04-standard-amd64-generic-v3.6.0-k3s-v1.32.9-k3s1`)
- Installs `wireguard` and `wireguard-tools` packages on top of the base image

The base image can be customized via the `KAIROS_BASE_IMAGE` build argument.

## Workflow Configuration

The GitHub Actions workflow (`.github/workflows/build.yml`) is configured to:

- Trigger on tag push (any tag matching `*`)
- Build for `amd64` architecture
- Use `generic` model
- Include k3s Kubernetes distribution
- Use git tag as version (via `version: auto`)
- Push to `quay.io/jimmykarily/kairos-wireguard`

## License

This project follows the same license as the upstream Kairos project.

## Related Projects

- [Kairos](https://github.com/kairos-io/kairos) - The upstream Kairos Linux distribution
- [Kairos Factory Action](https://github.com/kairos-io/kairos-factory-action) - Reusable GitHub Actions workflow for building Kairos images
