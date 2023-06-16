FROM docker.io/library/elixir:1.14-alpine as build

ENV MIX_ENV=prod

WORKDIR /app

COPY ./ /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

RUN mix deps.get
RUN mix deps.compile

RUN mix release

FROM docker.io/library/alpine:3.18 as user

RUN apk --update add build-base ncurses

RUN rm -rf /var/cache/apk/*

RUN adduser -D elixir

USER elixir

FROM user as app

RUN mkdir -p /home/elixir

WORKDIR /home/elixir

COPY --from=build --chown=elixir:elixir /app/_build/prod/rel/fake_logger ./

ENTRYPOINT [ "/home/elixir/bin/fake_logger" ]

CMD [ "start" ]