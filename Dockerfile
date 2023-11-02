FROM ubuntu:22.04 AS setup
ARG FOLDER
ARG VERSION
COPY ${FOLDER}/setup.sh /setup.sh
ADD https://cdn.geekbench.com/Geekbench-${VERSION}-Linux.tar.gz /tmp/Geekbench-${VERSION}-Linux.tar.gz
ADD https://cdn.geekbench.com/Geekbench-${VERSION}-LinuxARMPreview.tar.gz /tmp/Geekbench-${VERSION}-LinuxARMPreview.tar.gz
RUN /setup.sh

FROM ubuntu:22.04
COPY --from=setup /opt/geekbench /opt/geekbench
ENTRYPOINT [ "/opt/geekbench/geekbench" ]
