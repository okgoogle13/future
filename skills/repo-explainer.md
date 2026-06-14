---
name: repo-explainer
description: >
  Document and explain a code repository from uploaded files or a
  repomix snapshot. Use when asked to explain a codebase, understand
  a repo, generate onboarding docs, trace data flow, or summarize
  architecture. Use when the user uploads a repomix XML, README, or
  design doc and wants structured explanation.
---

# Repo Explainer

## Purpose
Generate structured, plain-English explanations of code repositories
using uploaded files as the primary source of truth.

## When to use
- Use when asked to explain, document, or onboard into a codebase.
- Use when a repomix snapshot or architecture doc is attached.
- Do not use for generic programming questions without repo context.

## Instructions
1. Identify all uploaded files; prioritise repomix XML, README, design docs.
2. Produce a 2–4 sentence plain-English summary.
3. List key components/modules with one-line descriptions.
4. Trace the main data/control flow in 5–10 bullet steps.
5. List important types, interfaces, or invariants.
6. When asked about a change: identify files, side-effects, and minimal change plan.
7. If context is missing, state what is needed but still answer best-effort.

## Output format
- Summary paragraph
- Module table (name | role | key files)
- Data/control flow bullets
- Change impact summary (if change was requested)
