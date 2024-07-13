# Dockerized Geekbench

[Geekbench](https://www.geekbench.com/) is a cross-platform benchmark that measures your system's performance with the press of a button.
The same, but through Docker, also for ARM.

- Maintained by: [e7d](https://github.com/e7d/docker-geekbench)
- Image available on: [Docker Hub](https://hub.docker.com/r/e7db/geekbench)

## Supported tags

| Tag | `amd64` | `arm64/v8` | `arm/v7` |
|-----|---------|------------|----------|
| `6.x.y`, `6.x`, `6`, `latest` | ✅ | ✅ | |
| `5.x.y`, `5.x`, `5` | ✅ | ✅ | ✅ |
| `4.x.y`, `4.x`, `4` | ✅ | | |
| `3.x.y`, `3.x`, `3` | ✅ | | |
| `2.x.y`, `2.x`, `2` | ✅ | | |


**Notes:**  
- Geekbench for ARM is available through [Preview Versions](https://www.geekbench.com/preview/). Issues are to be expected.

## Usage

```
docker run -it --rm e7db/geekbench
```
