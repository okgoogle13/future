#!/usr/bin/env python3
# validate-skills.py — Run from repo root after setup-future.sh
import re
import sys
from pathlib import Path

SKILLS_DIR = Path("skills")
errors = []
warnings = []

def read(p):
    return p.read_text(encoding="utf-8", errors="replace")

def check_skill(path):
    content = read(path)
    name = path.name
    if not content.startswith("---"):
        errors.append(f"{name}: missing YAML frontmatter ---")
        return
    fm_match = re.search(r"^---\n(.*?)\n---", content, re.DOTALL)
    if not fm_match:
        errors.append(f"{name}: malformed frontmatter")
        return
    fm = fm_match.group(1)
    if "name:" not in fm:
        errors.append(f"{name}: missing 'name:'")
    if "description:" not in fm:
        errors.append(f"{name}: missing 'description:'")
    for section in ["## When to use", "## Instructions", "## Output format"]:
        if section not in content:
            warnings.append(f"{name}: missing section '{section}'")
    if "do not use" not in content.lower():
        warnings.append(f"{name}: no negative boundary ('Do not use when')")
    desc_match = re.search(r"description:\s*[>|]?\s*\n?(.*?)(\n\w|\Z)", fm, re.DOTALL)
    if desc_match:
        desc = desc_match.group(1).strip()
        if len(desc) < 20:
            warnings.append(f"{name}: description too short")
        if "use when" not in desc.lower():
            warnings.append(f"{name}: description missing 'Use when' trigger")

print(f"Validating: {SKILLS_DIR.resolve()}")
print("-" * 50)
for skill_file in sorted(SKILLS_DIR.glob("*.md")):
    check_skill(skill_file)

if errors:
    print("\n❌ ERRORS:")
    for e in errors: print(f"  {e}")
if warnings:
    print("\n⚠  WARNINGS:")
    for w in warnings: print(f"  {w}")
if not errors and not warnings:
    print("✅ All skills valid.")
sys.exit(1 if errors else 0)
