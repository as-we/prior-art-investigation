#!/bin/bash
# ADR generation and archiving for Kiro Post-PR phase

set -e

# Read environment variables
KIRO_PHASE="${KIRO_PHASE:-post-pr}"
KIRO_FEATURE="${KIRO_FEATURE:-unknown}"
PRIOR_ART_ARCHIVE="${PRIOR_ART_ARCHIVE:-.kiro/prior-art-archive/}"

# ログ
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [prior-art-pr] $1"
}

log "Starting ADR generation and archiving for $KIRO_FEATURE"

# Run main logic via Python
python3 << 'PYTHON_EOF'
import json
import os
import sys
from pathlib import Path
from datetime import datetime

# Read config from environment
kiro_phase = os.environ.get("KIRO_PHASE", "post-pr")
kiro_feature = os.environ.get("KIRO_FEATURE", "unknown")
archive_dir = os.environ.get("PRIOR_ART_ARCHIVE", ".kiro/prior-art-archive/")

# Create archive directory
archive_path = Path(archive_dir)
archive_path.mkdir(parents=True, exist_ok=True)

# Load findings from previous phases in spec.json
spec_file = Path("spec.json")
all_findings = {}

if spec_file.exists():
    try:
        with open(spec_file) as f:
            spec = json.load(f)
        
        all_findings = spec.get("prior_art_findings", {})
    except Exception as e:
        print(f"[WARNING] Could not read spec.json: {e}", file=sys.stderr)

# ADR metadata
adr_metadata = {
    "metadata": {
        "feature": kiro_feature,
        "phase": kiro_phase,
        "timestamp": datetime.now().isoformat(),
        "adr_version": 1
    },
    "prior_art_context": all_findings,
    "summary": f"Architecture decisions for {kiro_feature} based on prior art investigation"
}

# Output as JSON
output = json.dumps(adr_metadata, indent=2)
print(output)

# Save to archive
archive_file = archive_path / f"{kiro_feature}_adr_context.json"
try:
    with open(archive_file, "w") as f:
        json.dump(adr_metadata, f, indent=2)
    print(f"[INFO] ADR context archived to {archive_file}", file=sys.stderr)
except Exception as e:
    print(f"[WARNING] Failed to archive ADR context: {e}", file=sys.stderr)

print(f"[SUCCESS] Prior Art context archived for PR process", file=sys.stderr)
PYTHON_EOF

log "✓ ADR generation and archiving completed"
exit 0
