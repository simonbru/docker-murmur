FROM busybox:latest

ARG VERSION=1.2.19

# Download statically compiled murmur and install it to /opt/murmur
ADD https://github.com/mumble-voip/mumble/releases/download/${VERSION}/murmur-static_x86-${VERSION}.tar.bz2 /opt/
RUN bzcat /opt/murmur-static_x86-${VERSION}.tar.bz2 | tar -x -C /opt -f - && \
    rm /opt/murmur-static_x86-${VERSION}.tar.bz2 && \
    mv /opt/murmur-static_x86-${VERSION} /opt/murmur

# Forward apporpriate ports
# 6502 is for ZeroC Ice
EXPOSE 64738/tcp 64738/udp 6502/udp

# Read murmur.ini and murmur.sqlite from /data/
VOLUME ["/data"]

# Run murmur
ENTRYPOINT ["/opt/murmur/murmur.x86", "-fg", "-v"]
CMD ["-ini", "/data/murmur.ini"]
