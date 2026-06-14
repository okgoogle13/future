---
name: codebase-extraction-summarizer
description: >
  Summarize a discussion or conversation into actionable codebase
  takeaways. Use when the user pastes conversation logs, design threads,
  or spec fragments and asks to distil them into interfaces, constraints,
  rules, or implementation patterns for a codebase. Do not use for
  general chat or unrelated summarization.
---

# Codebase Extraction Summarizer

## Purpose
Transform raw discussion into structured, reusable codebase artefacts:
interfaces, types, constraints, rules, and implementation patterns.

## When to use
- User pastes a conversation or spec and asks what to encode in code.
- User wants to derive interfaces, schemas, or guard-rails from a discussion.
- Do not use for generic summarization without codebase intent.

## Instructions
1. Read the pasted content and identify: main concepts, constraints, decisions, implementation ideas.
2. Separate "what was decided" from "what was discussed but not decided."
3. For each decided concept, output a structured capability record:
   - Title / intent
   - Trigger phrases
   - Required inputs
   - Deterministic workflow (ordered steps)
   - Output schema
   - Destination
4. Where applicable, provide TypeScript or Python interface stubs.
5. Flag any ambiguities explicitly.

## Output format
- One capability record block per extracted concept
- Optional: code stubs for interfaces or types
- Validation checklist at the end
