# future

A lightweight discovery log for exploring AI tools and prototyping ideas.

## Purpose

Capture findings from exploration sessions — what works, what doesn't, and what to try next — without over-engineering the structure.

## Structure

```
conversations/   ← raw notes and threads from discovery sessions
interfaces/      ← minimal schemas and data shapes that emerged from exploration
guidance/        ← practical patterns worth keeping, distilled from conversations
```

## How to use

1. Drop a new discovery note into `conversations/YYYY-MM-DD-topic-slug.md`
2. If a pattern or interface solidifies, move it into `guidance/` or `interfaces/`
3. Keep entries short — capture the finding, not the full conversation

## Current focus

Exploring Google AI Studio (Build mode) as a one-off prototyping tool.

Key findings so far:
- AI Studio Build mode generates code + files with a **live preview pane** in-browser — no deployment needed for personal use
- A single detailed prompt (system instructions + user message) is enough to produce a usable prototype
- Optimise prompts for in-Studio preview: single app, self-contained mock data, no external services or auth
- Prebuilt "remix" templates exist in the gallery as starting points
- Deploy to Cloud Run is available if a shareable URL is ever needed later
