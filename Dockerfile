FROM alpine:3 as fetcher

RUN apk add --no-cache --update wget unzip \
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /google-chrome.deb \
  && wget https://fonts.google.com/download?family=Open%20Sans -O /open-sans.zip \
  && mkdir -p /open-sans \
  && unzip -d /open-sans /open-sans.zip


FROM node:10-buster-slim

ENV PUPPETEER_SKIP_DOWNLOAD "true"
ENV PUPPETEER_EXECUTABLE_PATH "/usr/bin/google-chrome"
ENV RESUME_PUPPETEER_NO_SANDBOX "true"

COPY --from=fetcher /open-sans /usr/share/fonts/googlefonts
COPY --from=fetcher /google-chrome.deb /google-chrome.deb

RUN apt-get update \
  && apt-get install -y wget \
  && apt -y install /google-chrome.deb \
  && rm -f /google-chrome.deb \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g resume-cli@2.2.4 \
  && fc-cache -fv

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
