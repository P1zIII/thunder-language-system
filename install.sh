#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SKILL_NAME="thunder-language-system"
ACTION="install"
TARGET=""
THUNDER_LANGUAGE_HOME="${THUNDER_LANGUAGE_HOME:-$HOME}"

usage() {
  cat <<'EOF'
Usage:
  ./install.sh --target codex|claude-code|cursor
  ./install.sh --status
  ./install.sh --uninstall --target codex|claude-code|cursor

Install never overwrites an existing target. Remove it first with --uninstall.
EOF
}

target_path() {
  case "$1" in
    codex) printf '%s/skills/%s\n' "${CODEX_HOME:-$THUNDER_LANGUAGE_HOME/.codex}" "$SKILL_NAME" ;;
    claude-code) printf '%s/.claude/skills/%s\n' "$THUNDER_LANGUAGE_HOME" "$SKILL_NAME" ;;
    cursor) printf '%s/.cursor/rules/%s.mdc\n' "$THUNDER_LANGUAGE_HOME" "$SKILL_NAME" ;;
    *) return 1 ;;
  esac
}

copy_target() {
  destination=$1
  case "$TARGET" in
    codex)
      mkdir -p "$(dirname -- "$destination")"
      cp -R "$SCRIPT_DIR/$SKILL_NAME" "$destination"
      ;;
    claude-code)
      mkdir -p "$(dirname -- "$destination")"
      cp -R "$SCRIPT_DIR/adapters/claude-code" "$destination"
      ;;
    cursor)
      mkdir -p "$(dirname -- "$destination")"
      cp "$SCRIPT_DIR/adapters/cursor/$SKILL_NAME.mdc" "$destination"
      ;;
  esac
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --target)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      TARGET=$2
      shift 2
      ;;
    --status) ACTION="status"; shift ;;
    --uninstall) ACTION="uninstall"; shift ;;
    --help|-h) usage; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
done

if [ "$ACTION" = "status" ]; then
  for candidate in codex claude-code cursor; do
    location=$(target_path "$candidate")
    if [ -e "$location" ]; then
      printf '%s: installed at %s\n' "$candidate" "$location"
    else
      printf '%s: not installed\n' "$candidate"
    fi
  done
  exit 0
fi

[ -n "$TARGET" ] || { usage >&2; exit 2; }
DESTINATION=$(target_path "$TARGET") || { printf 'Unsupported target: %s\n' "$TARGET" >&2; exit 2; }

case "$ACTION" in
  install)
    [ ! -e "$DESTINATION" ] || { printf 'Refusing to overwrite existing target: %s\n' "$DESTINATION" >&2; exit 1; }
    copy_target "$DESTINATION"
    printf 'Installed %s for %s at %s\n' "$SKILL_NAME" "$TARGET" "$DESTINATION"
    ;;
  uninstall)
    [ -e "$DESTINATION" ] || { printf 'Not installed: %s\n' "$DESTINATION" >&2; exit 1; }
    rm -rf "$DESTINATION"
    printf 'Removed %s for %s from %s\n' "$SKILL_NAME" "$TARGET" "$DESTINATION"
    ;;
esac
