# Dockerized Geekbench

[Geekbench](https://www.geekbench.com/) is a cross-platform benchmark that measures your system's performance with the press of a button.
The same, but through Docker, also for ARM.

- Maintained by: [e7d](https://github.com/e7d/docker-geekbench)
- Image available on: [Docker Hub](https://hub.docker.com/r/e7db/geekbench)

## Supported tags

- `6.x.y`, `6.x`, `6`, `latest`
- `5.x.y`, `5.x`, `5`

**Notes:**  
- Supported architectures: `amd64`, `arm64/v8`, `arm/v7`.
- Geekbench for ARM is available through [Preview Versions](https://www.geekbench.com/preview/). Issues are to be expected.
- Geekbench 6 is not available for the `armv7` architecture.

## Usage

- Geekbench 6:
```
docker pull e7db/geekbench:6
docker run -it --rm e7db/geekbench:6
```

- Geekbench 5:
```
docker pull e7db/geekbench:5
docker run -it --rm e7db/geekbench:5
```
