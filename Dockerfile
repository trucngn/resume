FROM node:10-buster-slim

ENV PUPPETEER_SKIP_DOWNLOAD "true"

USER root
RUN apt-get update \
  && apt-get install -y wkhtmltopdf \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g resume-cli@2.2.4

USER node

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
