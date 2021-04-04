We bring you another container release featuring:

 * Regular and timely application updates
 * Easy user mappings (PGID, PUID)
 * Custom base image with s6 overlay

# [thespad/adguardhome-sync](https://github.com/thespad/docker-adguardhome-sync)

[![GitHub Stars](https://img.shields.io/github/stars/thespad/docker-adguardhome-sync.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/thespad/docker-adguardhome-sync)
[![GitHub Release](https://img.shields.io/github/release/thespad/docker-adguardhome-sync.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/thespad/docker-adguardhome-sync/releases)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=thespad&message=GitHub%20Package&logo=github)](https://github.com/thespad/docker-adguardhome-sync/packages)
[![Image Size](https://img.shields.io/docker/image-size/thespad/adguardhome-sync/latest?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Size)](#)
[![Docker Pulls](https://img.shields.io/docker/pulls/thespad/adguardhome-sync.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/thespad/adguardhome-sync)
[![Docker Stars](https://img.shields.io/docker/stars/thespad/adguardhome-sync.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/thespad/adguardhome-sync)

[AdGuardHome sync](https://github.com/bakito/adguardhome-sync) is a tool to synchronize AdGuardHome config to a replica instance

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`.

Simply pulling `ghcr.io/thespad/adguardhome-sync` should retrieve the correct image for your arch.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | latest |
| arm64 | latest |
| armv7 | latest |

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose ([recommended](https://docs.linuxserver.io/general/docker-compose))

Compatible with docker-compose v2 schemas.

```yaml
---
version: "2.1"
services:
  adguardhome-sync:
    image: ghcr.io/thespad/adguardhome-sync
    container_name: adguardhome-sync
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - </path/to/appdata/config>:/config
    ports:
      - 8080:8080
    restart: unless-stopped
```

### docker cli

```
docker run -d \
  --name=adguardhome-sync \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/New_York \
  -p 8080:8080 \
  -v </path/to/appdata/config>:/config \
  --restart unless-stopped \
  ghcr.io/thespad/adguardhome-sync
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8080` | http API |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=America/New_York` | Specify a timezone to use EG America/New_York |
| `-v /config` | Contains all relevant configuration files. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## Umask for running applications

For all of our images we provide the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add. Please read up [here](https://en.wikipedia.org/wiki/Umask) before asking for support.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Application Setup

Place config file into /config before starting container
Web API is accessible at http://SERVERIP:PORT
More info at [AdGuardHome sync](https://github.com/bakito/adguardhome-sync).

## Support Info

* To monitor the logs of the container in realtime: `docker logs -f adguardhome-sync`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. We do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull adguardhome-sync`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d adguardhome-sync`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run
* Update the image: `docker pull ghcr.io/thespad/adguardhome-sync`
* Stop the running container: `docker stop adguardhome-sync`
* Delete the container: `docker rm adguardhome-sync`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (only use if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once adguardhome-sync
  ```
* You can also remove the old dangling images: `docker image prune`

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using [Docker Compose](https://docs.linuxserver.io/general/docker-compose).

### Image Update Notifications - Diun (Docker Image Update Notifier)
* We recommend [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended or supported.

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:
```
git clone https://github.com/thespad/docker-adguardhome-sync.git
cd docker-adguardhome-sync
docker build \
  --no-cache \
  --pull \
  -t ghcr.io/thespad/adguardhome-sync:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **04.04.21:** - Initial Release.