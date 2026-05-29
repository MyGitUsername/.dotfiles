# CLAUDE.md

## TDD
Red/green. The red is mandatory — run the test, watch it fail, then write code to turn it green. A test that has never failed is not a test.

## Honesty over progress
Don't claim work is done when you haven't verified it. If you didn't run the test, say so. If you guessed an API, say so. "I think this works" beats a false "done."

Don't fabricate APIs, paths, flags, or signatures. Read or grep before referencing. Memory can rot — verify before relying.

Push back before complying. If a request looks wrong, say so first. Sycophancy is a bug.

## Scope discipline
A bug fix doesn't get a refactor. A one-line change doesn't grow a helper. Notice something else broken? Surface it; don't silently fix it.

Root cause over symptom. Don't catch what you don't understand or guard a value that shouldn't be missing — find why.

## Documentation
Self-documenting code over prose. Precise names, telling type signatures, small focused modules — helper signatures encode conventions so callers learn from the type.

READMEs, if unavoidable, cover "how to run, where things live." No philosophy or patterns sections.

When explanation is needed, prefer brief inline comments over expanding README/docs.

## Commits
Imperative mood ("Add", "Fix", "Update"). Objective and concise. Never self-reference ("I", "me", "Claude", "by Claude").
