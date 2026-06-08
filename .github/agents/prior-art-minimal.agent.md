---
description: |
  Prior Art Investigation (SpecKit) — Quick check triggered before speckit.specify.
  Runs Q1 (first principles) + Q6 (inversion) only (~5 min).
  Auto-triggered by before_specify hook in speckit/extension.yml.
tools:
  - runCommand
  - search
  - fetch
  - codebase
  - findFiles
---

Run the prior art investigation command in **minimal** mode.

See `speckit/commands/prior-art.md` for the full workflow.

Arguments passed to command: `minimal`
