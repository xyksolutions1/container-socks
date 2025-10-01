# nfrastack/container-socks

## About

This repository will build a container for a Socks5 Proxy.

* Auto Configuration Support

## Maintainer

- [Nfrastack](https://www.nfrastack.com)


## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Installation](#installation)
  - [Prebuilt Images](#prebuilt-images)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
- [Configuration](#configuration)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Core Configuration](#core-configuration)
  - [Users and Groups](#users-and-groups)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support & Maintenance](#support--maintenance)
- [License](#license)

## Installation

### Prebuilt Images
Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/container-socks/pkgs/container/container-socks) and [Docker Hub](https://hub.docker.com/r/nfrastack/socks).

To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

To get access to the image use your container orchestrator to pull from the following locations:

```
ghcr.io/nfrastack/container-socks:(image_tag)
docker.io/nfrastack/socks:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>`

Example:

`ghcr.io/nfrastack/container-socks:latest` or

`ghcr.io/nfrastack/container-socks:1.0` or


* `latest` will be the most recent commit
* An otpional `tag` may exist that matches the [CHANGELOG](CHANGELOG.md) - These are the safest
* If there are multiple distribution variations it may include a version - see the registry for availability

Have a look at the container registries and see what tags are available.

#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for your use.

* Map [persistent storage](#persistent-storage) for access to configuration and data files for backup.
* Set various [environment variables](#environment-variables) to understand the capabilities of this image.

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description                    |
| --------- | ------------------------------ |
| `/config` | (optional) Configuration Files |

### Environment Variables

#### Base Images used

This image relies on a customized base image in order to work.
Be sure to view the following repositories to understand all the customizable options:

| Image                                                   | Description |
| ------------------------------------------------------- | ----------- |
| [OS Base](https://github.com/nfrastack/container-base/) | Base Image  |

Below is the complete list of available options that can be used to customize your installation.

* Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.

#### Core Configuration

| Parameter              | Description                                 | Default               | `_FILE` |
| ---------------------- | ------------------------------------------- | --------------------- | ------- |
| `SOCKS_USER`           | What username to run as                     | `socks`               |         |
| `LISTEN_IP`            | Bind to which IP inside the container       | `0.0.0.0`             |         |
| `LISTEN_PORT`          | Bind to which port inside the container     | `1080`                |         |
| `CONFIG_PATH`          | Folder for Config Files                     | `/config/`            |         |
| `CONFIG_USER_FILE`     | User configuration file                     | `socks.user`          |         |
| `CUSTOM_CONFIG_PATH`   | Additional User provided configuration path | `${DATA_PATH}/conf.d` |         |
| `SOCKS_USER_NAME_PASS` | Password for the `NAME` user                |                       | x       |

>> You can add multiple users, just make more environment variables replacing `NAME` with the `USERNAME`
>> Each variable will create a new lowercase username with the password you have made
>> Not including any `SOCKER_USER_*_PASS` variables, or not having any entries in the `CONFIG_USER_FILE` will disable authentication (!)

## Users and Groups

| Type  | Name    | ID   |
| ----- | ------- | ---- |
| User  | `socks` | 1080 |
| Group | `socks` | 1080 |

### Networking

| Port   | Protocol | Description  |
| ------ | -------- | ------------ |
| `1080` | tcp      | Socks Daemon |

* * *

## Maintenance

### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.


## Support & Maintenance

- For community help, tips, and community discussions, visit the [Discussions board](/discussions).
- For personalized support or a support agreement, see [Nfrastack Support](https://nfrastack.com/).
- To report bugs, submit a [Bug Report](issues/new). Usage questions will be closed as not-a-bug.
- Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
- Updates are best-effort, with priority given to active production use and support agreements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
