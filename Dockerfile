ARG DISTRO=ubuntu
ARG RELEASE=xenial
FROM ${DISTRO}:${RELEASE}

MAINTAINER Sergey Ninua <sergeyn@gmail.com>

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        dpkg-dev devscripts dh-make lintian fakeroot quilt eatmydata vim sudo curl \
        equivs gcc \
    \
    && apt-get autoremove -y --purge && apt-get clean \
    && find /var/log/ /var/lib/apt/lists/ -type f -delete \
    && adduser --disabled-login --gecos '' builduser \
    && adduser builduser sudo \
    && mkdir /home/builduser/workdir \
    && chown builduser:builduser /home/builduser/workdir

COPY --chown=root:root .extra/nopasswd /etc/sudoers.d/nopasswd
COPY --chown=root:root .extra/entry /usr/bin/local/entry

USER builduser
WORKDIR /home/builduser/workdir

ENTRYPOINT ["/usr/bin/local/entry"]
CMD ["/bin/bash"]
