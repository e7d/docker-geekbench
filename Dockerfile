FROM ubuntu:22.04 AS setup
ARG VERSION
COPY setup.sh /setup.sh
ADD https://cdn.geekbench.com/Geekbench-${VERSION}-Linux.tar.gz /tmp/Geekbench-${VERSION}-Linux.tar.gz
ADD https://cdn.geekbench.com/Geekbench-${VERSION}-LinuxARMPreview.tar.gz /tmp/Geekbench-${VERSION}-LinuxARMPreview.tar.gz
RUN /setup.sh

FROM ubuntu:22.04
COPY --from=setup /opt/geekbench /opt/geekbench
COPY --from=setup /entrypoint.sh /entrypoint.sh
STOPSIGNAL SIGINT
ENTRYPOINT [ "/entrypoint.sh" ]
