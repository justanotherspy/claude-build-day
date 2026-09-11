# CLAUDE.md

## What this is

This repo is for the **Claude Fable 5.1 Build Day**. During the session,
Daniel will be running **live prompts given by Anthropic** against this repo,
so work must be small, working, and easy to explain out loud. Prefer the
simplest thing that runs. Checkpoint after each working step:
`sprite-env checkpoints create --comment "..."`.

Identity, SSH keys, signing, and GitHub gateway rules are in the parent
`../CLAUDE.md`. They apply here too.

## No browser: use headless Chromium via Playwright

This runs in a **Sprite VM with no display and no Chrome GUI**. You cannot
open a browser window. **Playwright and headless Chromium are already
installed** in this repo (`node_modules/playwright`, browser in
`~/.cache/ms-playwright`). Do not reinstall or look for another browser.

To see what a page looks like, screenshot it and then Read the PNG:

```
npx playwright screenshot --browser chromium --viewport-size 1280,800 http://127.0.0.1:8080/ shot.png
```

Delete screenshots afterwards; do not commit them. For anything beyond a
screenshot (clicking, reading console errors, checking text), write a short
Node script with `const { chromium } = require('playwright')` and run it.

Never claim a page renders correctly without looking at a screenshot.

## Serving the demo HTML on the Sprite URL

The demo is a **single static HTML document** in a folder in this repo
(for example `demo/index.html`). It is served on the Sprite URL by a
managed Sprite service, set up with:

```
./sprite-url.sh <relative path to html document>
```

- First run creates the `sprite-url` service on port 8080 and prints the
  public Sprite URL.
- Running it again with a different document **switches** the served
  document. No restart is needed; the server re-reads the target on every
  request.
- Assets (CSS, JS, images) referenced relatively from the HTML are served
  from the document's folder.
- `./sprite-url.sh --status` shows what is being served.
- `./sprite-url.sh --destroy` removes the service.

The Sprite URL is org-only by default. Make it public only if asked, with
`sprite url update --auth public` from outside the VM.

## Layout

- `sprite-url.sh` — sets up / switches the served document (see above).
- `scripts/serve.py` — the tiny HTTP server the service runs. Do not run it by hand.
- `demo/` — the HTML document built on the day lives here.
- `prompts/` — the live prompts for the day, one file each. Each says where to save the HTML and to serve it with `./sprite-url.sh`.
