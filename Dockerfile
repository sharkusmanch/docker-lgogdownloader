# Build stage
FROM alpine:3.20 AS builder

ARG LGOGDOWNLOADER_VERSION=3.17

RUN apk add --no-cache \
    build-base \
    cmake \
    ninja \
    curl-dev \
    boost-dev \
    jsoncpp-dev \
    tinyxml2-dev \
    rhash-dev \
    tidyhtml-dev \
    zlib-dev \
    git

WORKDIR /build

RUN curl -fsSL "https://github.com/Sude-/lgogdownloader/releases/download/v${LGOGDOWNLOADER_VERSION}/lgogdownloader-${LGOGDOWNLOADER_VERSION}.tar.gz" \
    | tar xz --strip-components=1

RUN cmake -B build -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DUSE_QT_GUI=OFF \
    && cmake --build build \
    && DESTDIR=/install cmake --install build

# Runtime stage
FROM alpine:3.20

RUN apk add --no-cache \
    libcurl \
    boost1.84-regex \
    boost1.84-date_time \
    boost1.84-system \
    boost1.84-filesystem \
    boost1.84-program_options \
    boost1.84-iostreams \
    jsoncpp \
    tinyxml2 \
    rhash-libs \
    tidyhtml-libs \
    zlib \
    ca-certificates \
    && adduser -D -u 1000 lgog

COPY --from=builder /install/usr/bin/lgogdownloader /usr/bin/lgogdownloader

USER lgog
WORKDIR /home/lgog

VOLUME ["/home/lgog/.config/lgogdownloader", "/games"]

ENTRYPOINT ["lgogdownloader"]
CMD ["--help"]
