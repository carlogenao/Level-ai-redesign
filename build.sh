#!/bin/sh
# Wraps the artifact page in a full HTML document for any static host (dist/).
set -e
cd "$(dirname "$0")"
rm -rf dist && mkdir -p dist && cp -r assets dist/
{ printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n</head>\n<body>\n'; cat index.html; printf '\n</body>\n</html>\n'; } > dist/index.html
echo "built dist/"
