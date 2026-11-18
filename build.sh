#!/bin/sh
# Builds dist/ for a real static host: full HTML documents, assets,
# and Lily's website chat wired to the public ElevenLabs agent.
set -e
cd "$(dirname "$0")"
AGENT_ID="${LILY_AGENT_ID:-agent_5901m6m5m5svftmvzghpnr0dm6hb}"   # public agent ID, not a secret
WIDGET_SRC="https://unpkg.com/@elevenlabs/convai-widget-embed@0.24.0"
INQUIRY_ENDPOINT="${INQUIRY_ENDPOINT:-}"                      # e.g. /api/intake on the production host

rm -rf dist && mkdir -p dist && cp -r assets dist/
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n</head>\n<body>\n'
  cat index.html
  printf '\n</body>\n</html>\n'
} > dist/index.html
python3 - "$INQUIRY_ENDPOINT" <<'PY'
import sys
p = 'dist/index.html'; s = open(p).read()
endpoint = sys.argv[1]
s = s.replace("elevenLabs: { chatPage: null }", "elevenLabs: { chatPage: 'lily-chat.html' }")
if endpoint:
    s = s.replace("inquiryEndpoint: null", "inquiryEndpoint: '" + endpoint + "'")
open(p, 'w').write(s)
PY
sed -e "s#__AGENT_ID__#$AGENT_ID#" -e "s#__WIDGET_SRC__#$WIDGET_SRC#" lily-chat.html > dist/lily-chat.html
echo "built dist/ (chat: on, inquiry endpoint: ${INQUIRY_ENDPOINT:-not set})"
