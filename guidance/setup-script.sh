#!/usr/bin/env bash
# setup-future.sh — Bootstrap okgoogle13/future knowledge base
set -euo pipefail

GITHUB_USER="okgoogle13"
REPO_NAME="future"
SOURCE_DIR="${HOME}/perplexity-exports"
OUTPUT_DIR="${HOME}/future-output"
SOURCE_SKILLS_DIR="/Users/okgoogle13/Projects/Computer purchase/.claude/skills"
KIT_ROOT="${HOME}/perplexity-prototype-kit"
BUILD_DIR="${KIT_ROOT}/build"
STAGING_DIR="${KIT_ROOT}/staging"
SOURCE_SNAPSHOT_DIR="${STAGING_DIR}/source-snapshot"

echo "→ Creating output structure..."
mkdir -p \
  "${OUTPUT_DIR}/conversations" \
  "${OUTPUT_DIR}/guidance" \
  "${OUTPUT_DIR}/interfaces" \
  "${OUTPUT_DIR}/skills" \
  "${STAGING_DIR}/capabilities" \
  "${STAGING_DIR}/skill-drafts" \
  "${SOURCE_SNAPSHOT_DIR}" \
  "${BUILD_DIR}"

if [ -d "${SOURCE_SKILLS_DIR}" ]; then
  echo "→ Snapshotting Claude skills..."
  cp -r "${SOURCE_SKILLS_DIR}/." "${SOURCE_SNAPSHOT_DIR}/"
else
  echo "⚠  Claude skills dir not found, skipping: ${SOURCE_SKILLS_DIR}"
fi

if [ -d "${SOURCE_DIR}" ]; then
  echo "→ Processing Perplexity exports..."
  for f in "${SOURCE_DIR}"/*.md; do
    [ -f "$f" ] || continue
    filename=$(basename "$f")
    if grep -qi "^---" "$f" && grep -qi "^name:" "$f"; then
      dest="${OUTPUT_DIR}/skills/${filename}"; type="skill"
    elif grep -qi "^# .*interface\|^# .*type\|^# .*schema" "$f"; then
      dest="${OUTPUT_DIR}/interfaces/${filename}"; type="interface"
    elif grep -qi "guidance\|rules\|patterns\|constraints" "$f"; then
      dest="${OUTPUT_DIR}/guidance/${filename}"; type="guidance"
    else
      dest="${OUTPUT_DIR}/conversations/${filename}"; type="conversation"
    fi
    sed -e 's|<img[^>]*>||g' -e 's|<span[^>]*>||g' -e 's|</span>||g' \
        -e 's|<div[^>]*>||g' -e 's|</div>||g' "$f" > "$dest"
    echo "  [${type}] ${filename}"
  done
else
  echo "⚠  Source dir not found: ${SOURCE_DIR}"
fi

cat > "${BUILD_DIR}/BUILD_NOTES.txt" << EOF
Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
GitHub repo: ${GITHUB_USER}/${REPO_NAME}
Output: ${OUTPUT_DIR}
EOF

echo ""
echo "✅ Done. Output: ${OUTPUT_DIR}"
echo "   Push with: cd ${OUTPUT_DIR} && git init && git remote add origin git@github.com:${GITHUB_USER}/${REPO_NAME}.git && git add -A && git commit -m 'feat: import space export' && git push -u origin main"
