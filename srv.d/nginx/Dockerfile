ARG build=production

FROM nginx:stable-alpine AS base

FROM base AS production
COPY conf.d/production.conf /etc/nginx/conf.d/default.conf

FROM base AS development
COPY conf.d/development.conf /etc/nginx/conf.d/default.conf

FROM $build
