#!/bin/bash -l

set -euo pipefail

WORKDIR=${WORKDIR:-/github/workspace}
cd ${WORKDIR}

# retrieve and install jsonresume theme
wget "$1" -O /theme.tgz
npm install /theme.tgz

# export to HTML
resume export -t ./node_modules/jsonresume-theme-eloquent resume.html

# generate PDF
wkhtmltopdf -s A4 -B 10 -L 10 -R 10 -T 10 --no-background --javascript-delay 3000 resume.html resume.pdf
