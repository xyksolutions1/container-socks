# SPDX-FileCopyrightText: © 2025 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG \
    BASE_IMAGE

FROM docker.io/xyksolutions1/container-base:latest

LABEL \
        org.opencontainers.image.title="Socks" \
        org.opencontainers.image.description="Protect your feet" \
        org.opencontainers.image.url="https://hub.docker.com/r/xyksolutions1/socks" \
        org.opencontainers.image.documentation="https://github.com/xyksolutions1/container-socks/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/xyksolutions1/container-socks.git" \
        org.opencontainers.image.authors="xyksolutions1" \
        org.opencontainers.image.vendor="xyksolutions1" \
        org.opencontainers.image.licenses="MIT"

ARG \
    SOCKS_VERSION="1.0.0" \
    SOCKS_REPO_URL="https://github.com/ariadata/go-socks5-proxy"

ENV \
    CONTAINER_ENABLE_SCHEDULING=TRUE \
    IMAGE_NAME="xyksolutions1/socks" \
    IMAGE_REPO_URL="https://github.com/xyksolutions1/container-socks/"


COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

RUN echo "" && \
    export SOCKS_BUILD_DEPS_ALPINE="  \
                                    build-base \
                                   " \
                                 && \
    export SOCKS_BUILD_DEPS_DEBIAN="  \
                                   " \
                                    && \
    export SOCKS_RUN_DEPS_ALPINE="  \
                                    apache2-utils \
                                 " && \
    \
    source /container/base/functions/container/build && \
    container_build_log image && \
    create_user socks 1080 socks 1080 /dev/null && \
    package update && \
    package upgrade && \
    package install \
                    SOCKS_BUILD_DEPS \
                    SOCKS_RUN_DEPS \
                    && \
    package build go && \
    clone_git_repo "${SOCKS_REPO_URL}" "${SOCKS_VERSION}" && \
    go build \
                -ldflags " \
                            -s \
                            -w \
                         " \
                -o /usr/local/bin/go-socks5-proxy \
                && \
    container_build_log add "Socks" "${SOCKS_VERSION}" "${SOCKS_REPO_URL}" && \
    package remove \
                    SOCKS_BUILD_DEPS \
                    && \
    package cleanup

EXPOSE 1080

COPY rootfs /
