# Google AI Studio Config for Vibe-Coding
> **Model:** `gemini-3.1-pro-preview` (GA February 2026) | **Last updated:** 2026-06-14

---

## Advanced Settings

| Setting | Value | Rationale |
|---|---|---|
| **Model** | `gemini-3.1-pro-preview` | GA since Feb 2026 — strongest reasoning + SWE-bench 80.6%, ARC-AGI-2 77.1% |
| **Temperature** | `0.2` | Lower than before — 3.1 Pro's adaptive thinking benefits from tighter control |
| **Top-P** | `0.85` | Slightly tighter than 2.5 Pro — 3.1's reasoning is more self-directed |
| **Top-K** | `40` | Standard |
| **Max output tokens** | `65536` | 3.1 Pro outputs up to 64k — full prototype in one shot |
| **Thinking budget** | `auto` | Let adaptive thinking allocate compute; disable only for trivial tasks |
| **Safety settings** | All `BLOCK_NONE` | Prevent blocking code patterns; re-enable for prod |
| **Grounding** | `OFF` | Deterministic vibe-coding sessions; enable only for research prompts |
| **Code execution** | `ON` | 3.1 Pro has native tool use — let Studio validate snippets inline |
| **Structured output** | `OFF` | Plain markdown + fenced code blocks is faster and more readable |
| **Context window** | 1M tokens | Use full window for large repomix dumps or multi-file uploads |

> **Note:** Gemini 3.5 Pro is announced (Sundar Pichai, May 2026) but not yet released as of June 2026.
> When it lands, re-run evals and update model ID to `gemini-3.5-pro` before migrating.
> For now, `gemini-3.1-pro-preview` is the correct production choice.

---

## System Instruction (paste into AI Studio → System instructions field)

```
## ROLE
You are an expert agentic vibe-coding engineer inside Google AI Studio.
You have access to Gemini 3.1 Pro's adaptive reasoning, 1M-token context,
and native code execution. Use all three.

## IDENTITY
- Developer: okgoogle13 (Melbourne, AU, student)
- Stack default: TypeScript 5+ / Node 22, minimal deps, platform primitives first
- Code quality bar: production scaffold — typed, error-handled, idempotent
- No toy code. No placeholders. No "// TODO: implement this".

## THINKING PROTOCOL (adaptive reasoning)
Before writing a single line of code:
1. Silently reason through the full architecture (use thinking tokens).
2. Identify: entry points, data contracts, external dependencies, failure modes.
3. Then surface a 3-bullet understanding check — only what would change the build
   if you got it wrong. Do not narrate the whole plan.

## BUILD PROTOCOL
Execute in this exact order. Do not skip steps.

### Step 1 — Confirm understanding
Output exactly 3 bullets:
- What this builds (one sentence)
- The primary constraint or non-obvious requirement
- The first decision you're making and why

### Step 2 — File tree
Emit the full directory structure as a tree before writing any file.
Mark each file as: [new] or [config] or [test].

### Step 3 — Implement files
For each file, in tree order:
  ### path/to/file.ext
  ```language
  <complete file content — no ellipsis, no stubs>
  ```
  > One sentence explaining any non-obvious choice made in this file.

### Step 4 — Environment and setup
Emit:
- `.env.example` with all required keys and inline comments
- `package.json` (or equivalent) with all deps and scripts
- `README.md` with: what it does, prerequisites, install, run, test

### Step 5 — Self-verification
Before finishing, check and confirm each item:
- [ ] All imports resolve to declared deps
- [ ] No `any` types (flag intentional exceptions with `// safe: <reason>`)
- [ ] Entry point is unambiguous
- [ ] Idempotent: re-running produces the same output
- [ ] Error paths are handled (no silent failures)
- [ ] `.env.example` covers every `process.env.*` reference in code

If any check fails, fix it before outputting the final block.

## AMBIGUITY RULE
When the spec is ambiguous:
- Make a decision.
- State it in one sentence: "Decision: [X] because [Y]."
- Continue. Do not stop to ask unless the ambiguity would cause
  fundamentally wrong architecture (e.g. wrong database engine, wrong auth model).

## OUTPUT RULES
- Fenced code blocks with language tags for all code.
- File headers as `### path/to/file.ext` (H3 markdown).
- Prose explanations are one sentence max per file.
- No preamble. No "Sure, here's your code!" filler.
- No summaries at the end. The code is the output.
```

---

## Build Prompt — Perplexity Space Knowledge Extractor
> Paste as your **first user message** after setting the system instruction above.

```
## BUILD SPEC — future knowledge base CLI extractor

### Context
Developer: okgoogle13 | Repo: github.com/okgoogle13/future (public)
This tool extracts, classifies, and pushes Perplexity Space Markdown exports
into the structured `future` repo. It replaces manual copy-paste.

### Input
- Source: `~/perplexity-exports/*.md` (raw Perplexity Space conversation exports)
- Config: `.future-config.json` at project root
  {
    "githubToken": "...",
    "owner": "okgoogle13",
    "repo": "future",
    "branch": "main"
  }

### Output targets (repo folders)
- conversations/YYYY-MM-DD-slug.md   — raw thread exports, HTML artifacts stripped
- skills/skill-name.md               — SKILL.md files (detected by YAML frontmatter + name:)
- guidance/topic-slug.md             — rules, patterns, config, templates
- interfaces/TypeName.md             — TypeScript interface/schema stubs
- SUMMARY.md                         — auto-generated table (File | Type | Date | Title | Words)
- index.json                         — machine-readable manifest of all artefacts

### Classification logic
Priority order (first match wins):
1. Has `---` frontmatter AND `name:` field → skills/
2. First H1 contains "interface" OR "type" OR "schema" → interfaces/
3. Filename or content contains "guidance|rules|patterns|config|template" → guidance/
4. Fallback → conversations/

### Stack
- Runtime: Node.js 22 / TypeScript 5
- CLI: plain `process.argv` (no commander — keep it zero-dep outside npm)
- Markdown parsing: `unified` + `remark-parse` + `remark-frontmatter`
- GitHub push: `@octokit/rest`
- HTML stripping: regex (no DOM parser — keep it lightweight)

### Behaviour requirements
- Idempotent: re-running must not duplicate files or commits
- Dry-run mode: `--dry-run` flag prints what would be pushed, pushes nothing
- Verbose mode: `--verbose` logs each file's classified type and destination
- On classification ambiguity: log a warning, put file in conversations/, continue
- Strip from Markdown: `<img>`, `<span>`, `<div>` tags and Perplexity footnote spans

### Entry point
`npx ts-node src/index.ts [--dry-run] [--verbose]`
No build step required.

### Stretch (implement only after core is working)
- `src/viewer/index.html` — single-file HTML viewer that fetches `index.json`
  and renders a searchable, filterable table of artefacts
- `.github/workflows/sync.yml` — GitHub Action that runs the extractor on push
  to the source branch

Build it now. Follow the build protocol exactly.
```

---

## Quick Reference — Model IDs (June 2026)

| Model | ID | Status | Best for |
|---|---|---|---|
| Gemini 3.1 Pro | `gemini-3.1-pro-preview` | ✅ GA | Reasoning, agentic coding, long context |
| Gemini 3.5 Flash | `gemini-3.5-flash` | ✅ GA | Fast iteration, interactive tasks |
| Gemini 3.1 Flash-Lite | `gemini-3.1-flash-lite` | ✅ GA | Cost-efficient, high volume |
| Gemini 3.5 Pro | `gemini-3.5-pro` | 🔜 ~July 2026 | Successor to 3.1 Pro |
| Gemini 2.5 Pro | `gemini-2.5-pro` | ✅ GA (stable) | Long-context fallback, cheaper |
| Gemini 2.0 Flash | — | ❌ Retired Jun 2026 | — |
