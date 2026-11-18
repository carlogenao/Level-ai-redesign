# Level AI website redesign

Static redesign of level-ai.io. No build tools needed.

- `index.html` is the page source. It is also the published claude.ai preview.
- `assets/` holds the Level AI logo (plus a dark-mode copy) and the background platform logos.
- `./build.sh` wraps the page into a full HTML document in `dist/` for any static host.

## Configuration

Set `window.LEVEL_CONFIG` near the bottom of `index.html`. No secrets go in client code.

- `inquiryEndpoint`: a same-origin POST endpoint (for example `/api/intake`) that returns `{ id }` on success. When it's unset on a normal host, the form says storage isn't connected and saves nothing.
- `elevenLabs.agentId` and `elevenLabs.scriptSrc`: the approved public ElevenLabs widget settings. When they're unset, Text Lily shows as unavailable.
