FROM rust:latest as builder

WORKDIR /usr/src/rots
COPY . .

RUN rustup install nightly
ENV CARGO_UNSTABLE_SPARSE_REGISTRY true
RUN cargo +nightly build -Z no-index-update --path server

FROM debian:buster-slim AS runtime

COPY --from=builder /usr/src/rots/target/debug/server ./server

CMD ["./server"]
