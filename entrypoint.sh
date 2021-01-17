#!/bin/bash -l

set -euo pipefail

WORKDIR=${WORKDIR:-/github/workspace}
cd ${WORKDIR}

# retrieve and install jsonresume theme
wget "$1" -O /theme.tgz
npm install /theme.tgz
package_name=$(npm pack /theme.tgz --dry-run 2>&1 | grep "^npm notice name:" | sed 's/npm notice name:\s*\(.*\)/\1/')

# export to HTML
resume export -t ./node_modules/$package_name resume.html

# generate PDF
wkhtmltopdf -s A4 -B 10 -L 10 -R 10 -T 10 --no-background --javascript-delay 3000 resume.html resume.pdf
