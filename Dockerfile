FROM alpine:3 as fetcher

RUN apk add --no-cache --update wget unzip \
  && wget https://fonts.google.com/download?family=Open%20Sans -O /open-sans.zip \
  && mkdir -p /open-sans \
  && unzip -d /open-sans /open-sans.zip


FROM node:10-buster-slim

ENV PUPPETEER_SKIP_DOWNLOAD "true"

COPY --from=fetcher /open-sans /usr/share/fonts/googlefonts

RUN apt-get update \
  && apt-get install -y wget wkhtmltopdf \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g resume-cli@2.2.4 \
  && fc-cache -fv

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
