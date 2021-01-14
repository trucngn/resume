FROM node:10-buster-slim

ENV PUPPETEER_SKIP_DOWNLOAD "true"

RUN apt-get update \
  && apt-get install -y wget wkhtmltopdf \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g resume-cli@2.2.4

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
