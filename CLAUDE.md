# CLAUDE.md — future repo agent instructions

## Project identity
Knowledge base extracted from Perplexity Space conversations by okgoogle13 (Melbourne, AU).

## Folder contract
| Folder | Contents | Naming convention |
|---|---|---|
| `conversations/` | Raw exported threads | `YYYY-MM-DD-topic-slug.md` |
| `guidance/` | Codebase rules, patterns, config | `topic-slug.md` |
| `interfaces/` | TypeScript/schema stubs | `TypeName.md` |
| `skills/` | Perplexity SKILL.md files | `skill-name.md` (YAML frontmatter required) |

## When adding a file
1. Correct folder per table above.
2. YAML frontmatter: `title`, `date`, `type`.
3. Update `SUMMARY.md` — add a table row.
4. Update `index.json` — add entry to manifest array.

## When asked to extract from a conversation
1. Identify main concepts, constraints, decisions.
2. Separate decided from undecided.
3. Output capability records for each decided concept.
4. Generate interface stubs where applicable.
5. Place outputs in correct folders.

## Style rules
- Plain GFM Markdown only. No HTML except legacy imports.
- Tables for comparisons, bullets for lists, code blocks for all code.
- No placeholder TODOs — mark incomplete as `> ⚠️ INCOMPLETE: <what's missing>`
