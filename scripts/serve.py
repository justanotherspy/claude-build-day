#!/usr/bin/env python3
"""Serve one static HTML document (plus sibling assets) for the Sprite URL.

The path of the document is read from a state file on EVERY request, so
switching documents only requires rewriting that file. No restart needed.

Usage: serve.py <state-file> <port>
"""
import http.server
import mimetypes
import os
import sys
from pathlib import Path

STATE_FILE = Path(sys.argv[1])
PORT = int(sys.argv[2])


def current_target() -> Path | None:
    try:
        p = Path(STATE_FILE.read_text().strip())
    except OSError:
        return None
    return p if p.is_file() else None


class Handler(http.server.BaseHTTPRequestHandler):
    server_version = "sprite-url/1.0"

    def do_GET(self):
        self._serve(head=False)

    def do_HEAD(self):
        self._serve(head=True)

    def _serve(self, head: bool):
        target = current_target()
        if target is None:
            body = b"<h1>sprite-url: no document configured</h1><p>Run ./sprite-url.sh &lt;path/to/file.html&gt;</p>"
            return self._send(503, "text/html; charset=utf-8", body, head)

        rel = self.path.split("?", 1)[0].split("#", 1)[0].lstrip("/")
        if rel in ("", "index.html"):
            path = target
        else:
            root = target.parent.resolve()
            path = (root / rel).resolve()
            # Never escape the document's folder.
            if root not in path.parents and path != root:
                return self._send(404, "text/plain", b"not found", head)
            if path.is_dir():
                path = path / "index.html"
        if not path.is_file():
            return self._send(404, "text/plain", b"not found", head)

        ctype = mimetypes.guess_type(str(path))[0] or "application/octet-stream"
        if ctype.startswith("text/"):
            ctype += "; charset=utf-8"
        try:
            data = path.read_bytes()
        except OSError:
            return self._send(500, "text/plain", b"read error", head)
        self._send(200, ctype, data, head)

    def _send(self, code: int, ctype: str, body: bytes, head: bool):
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        # Live demo: never cache, so edits show on refresh.
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        if not head:
            self.wfile.write(body)

    def log_message(self, fmt, *args):
        sys.stderr.write("%s %s\n" % (self.address_string(), fmt % args))
        sys.stderr.flush()


if __name__ == "__main__":
    http.server.ThreadingHTTPServer.allow_reuse_address = True
    with http.server.ThreadingHTTPServer(("0.0.0.0", PORT), Handler) as srv:
        print(f"sprite-url serving on :{PORT}, state file {STATE_FILE}", flush=True)
        srv.serve_forever()
