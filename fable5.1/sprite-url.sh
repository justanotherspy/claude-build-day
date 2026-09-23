#!/usr/bin/env bash
# Serve a single static HTML document from this repo on the Sprite URL.
#
#   ./sprite-url.sh <relative path to .html>   set up (or switch to) a document
#   ./sprite-url.sh --status                   show what is being served
#   ./sprite-url.sh --destroy                  remove the service
#
# First run creates a managed Sprite service ("sprite-url") on port 8080.
# Later runs just rewrite the state file; the server re-reads it per request,
# so switching documents is instant and needs no restart.
set -euo pipefail

SERVICE=sprite-url
PORT=8080
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVE_PY="$REPO_DIR/scripts/serve.py"
STATE_DIR="$HOME/.sprite-url"
STATE_FILE="$STATE_DIR/target"
PYTHON="$(python3 -c 'import sys; print(sys.executable)')"

say()  { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2; exit 1; }

sprite_url() { sprite-env info 2>/dev/null | jq -r '.sprite_url // empty'; }
service_exists() { sprite-env services list 2>/dev/null | jq -e --arg n "$SERVICE" 'map(select(.name==$n)) | length > 0' >/dev/null; }
service_state()  { sprite-env services list 2>/dev/null | jq -r --arg n "$SERVICE" '.[] | select(.name==$n) | .state.status // .status // "unknown"'; }

wait_healthy() {
  for _ in $(seq 1 30); do
    if curl -sf -o /dev/null "http://127.0.0.1:$PORT/"; then return 0; fi
    sleep 0.5
  done
  return 1
}

cmd_status() {
  if service_exists; then
    say "service '$SERVICE' state: $(service_state)"
  else
    say "service '$SERVICE' not created"
  fi
  if [[ -f "$STATE_FILE" ]]; then
    say "serving: $(cat "$STATE_FILE")"
  else
    say "serving: (nothing configured)"
  fi
  say "url: $(sprite_url)"
}

cmd_destroy() {
  if service_exists; then
    say "deleting service '$SERVICE'"
    sprite-env services delete "$SERVICE" >/dev/null
  else
    say "service '$SERVICE' does not exist"
  fi
  rm -f "$STATE_FILE"
  say "done"
}

cmd_serve() {
  local rel="$1"
  local abs
  abs="$(cd "$REPO_DIR" && realpath -e -- "$rel" 2>/dev/null)" || die "no such file: $rel (path is relative to the repo root)"
  [[ -f "$abs" ]] || die "not a file: $abs"
  case "$abs" in "$REPO_DIR"/*) ;; *) die "document must live inside this repo: $REPO_DIR" ;; esac
  case "${abs,,}" in *.html|*.htm) ;; *) warn "'$rel' does not end in .html; serving it anyway" ;; esac
  [[ -f "$SERVE_PY" ]] || die "missing server script: $SERVE_PY"

  mkdir -p "$STATE_DIR"
  printf '%s\n' "$abs" > "$STATE_FILE"
  say "target: $abs"

  if ! service_exists; then
    say "creating service '$SERVICE' on port $PORT"
    sprite-env services create "$SERVICE" \
      --cmd "$PYTHON" \
      --args "$SERVE_PY,$STATE_FILE,$PORT" \
      --dir "$REPO_DIR" \
      --http-port "$PORT" \
      --no-stream >/dev/null
  else
    local st; st="$(service_state)"
    if [[ "$st" != "running" ]]; then
      say "service exists (state: $st); starting"
      sprite-env services start "$SERVICE" >/dev/null || true
    else
      say "service already running; switched document (no restart needed)"
    fi
  fi

  if wait_healthy; then
    say "healthy: http://127.0.0.1:$PORT/ -> $(basename "$abs")"
  else
    warn "service did not answer on :$PORT within 15s"
    warn "logs: sprite-env services get $SERVICE   /   ls /.sprite/logs/services/"
    exit 1
  fi

  echo
  say "LIVE AT: $(sprite_url)"
  echo
}

case "${1:-}" in
  ""|-h|--help) sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
  --status)     cmd_status ;;
  --destroy)    cmd_destroy ;;
  --*)          die "unknown flag: $1" ;;
  *)            cmd_serve "$1" ;;
esac
