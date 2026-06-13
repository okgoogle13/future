# future

A clean knowledge base extracted from Perplexity Space conversations.

## Structure

```
conversations/   ← raw Markdown exports from Perplexity Space threads
interfaces/      ← reusable types, schemas, and interfaces derived from discussions
guidance/        ← consolidated codebase rules and implementation patterns
```

## How to add a conversation

1. Export the thread as Markdown (via MarkDownload or Perplexity's copy option)
2. Save to `conversations/YYYY-MM-DD-topic-slug.md`
3. Push via MCP `push_files` or standard `git commit`

## Workflow

Conversations → distilled into `guidance/` and `interfaces/` as patterns solidify.
