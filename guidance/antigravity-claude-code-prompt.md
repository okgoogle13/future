# Antigravity CLI / Claude Code Bootstrap Prompt

Paste into Claude Code or run in Antigravity IDE terminal:

```
You are Claude Code operating in an Antigravity IDE environment.
Your task is to bootstrap the `future` knowledge base from exported
Perplexity Space Markdown files.

Context:
- GitHub repo: okgoogle13/future (public)
- Local source: ~/perplexity-exports/ (Markdown files)
- Skills dir: /Users/okgoogle13/Projects/Computer purchase/.claude/skills/
- Target structure: conversations/ | guidance/ | interfaces/ | skills/

Execute in order:

Phase 1 — Inventory:
1. List all .md files in ~/perplexity-exports/
2. For each: extract title (H1), date, word count, content type
   (conversation | skill | spec | guidance)
3. Output manifest to ~/perplexity-exports/manifest.json

Phase 2 — Classify and copy:
4. Copy to correct output folder with cleaned names
5. Strip Perplexity HTML artifacts (img tags, footnote spans)

Phase 3 — Generate indexes:
6. Write output/SUMMARY.md (table: File | Type | Date | Title | Words)
7. Write output/index.json (machine-readable manifest)

Phase 4 — Push to GitHub:
8. Use GitHub MCP push_files to commit all output/ to
   okgoogle13/future, branch main
   Commit: "feat: import Perplexity space export YYYY-MM-DD"

Phase 5 — Validate:
9. Confirm all files pushed successfully
10. Report parsing errors or classification failures

Constraints:
- Do not invent content — only extract and restructure what exists
- Flag ambiguous files rather than silently miscategorising
- Preserve Markdown formatting, only strip HTML artifacts
- Use filesystem MCP tools for all file operations

Begin with Phase 1. Show manifest before proceeding to Phase 2.
```

## CLAUDE.md for the future repo root

```markdown
# CLAUDE.md

## Folder contract
| Folder | Contents | Naming |
|---|---|---|
| conversations/ | Raw exported threads | YYYY-MM-DD-topic-slug.md |
| guidance/ | Codebase rules, patterns | topic-slug.md |
| interfaces/ | TypeScript/schema stubs | TypeName.md |
| skills/ | Perplexity SKILL.md files | skill-name.md |

## When adding a file
1. Correct folder per table.
2. YAML frontmatter: title, date, type.
3. Update SUMMARY.md and index.json.

## When extracting from a conversation
1. Identify concepts, constraints, decisions.
2. Separate decided from undecided.
3. Output capability records per concept.
4. Generate interface stubs where applicable.
```
