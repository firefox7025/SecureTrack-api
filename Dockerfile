FROM rust:1-bullseye as builder
RUN mkdir /build
COPY ["Cargo.toml", "Cargo.lock", "/build/"]
ADD src /build/src
WORKDIR /build
RUN cargo build --release

FROM debian:bullseye
RUN mkdir /app
COPY --from=builder /build/target/securetrack_api /app/securetrack_api
EXPOSE 8080
CMD "/app/securetrack_api"