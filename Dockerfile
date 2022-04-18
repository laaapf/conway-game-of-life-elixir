FROM alpine:3.15

WORKDIR /app

COPY . /app

ENV USER ROOT

RUN apk add elixir
RUN apk add make
