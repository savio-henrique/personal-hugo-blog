FROM ghcr.io/gohugoio/hugo:v0.152.2 AS base

WORKDIR /www
COPY --chown=1000:1000 . /www

USER 1000:1000

FROM base AS builder

RUN hugo build --minify

FROM base as dev

FROM nginx:alpine AS production

COPY --from=builder /www/public/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
