---
description: |
  Prior Art Investigation (SpecKit) — Full investigation triggered before speckit.plan.
  Runs all 7 questions + OSS matrix + Build vs Use decision (~20 min).
  Auto-triggered by before_plan hook in speckit/extension.yml.
tools:
  - runCommand
  - search
  - fetch
  - codebase
  - findFiles
---

Run the prior art investigation command in **full** mode.

See `speckit/commands/prior-art.md` for the full workflow.

Arguments passed to command: `full`
