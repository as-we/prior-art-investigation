#!/usr/bin/env python3
"""
MCP Server for Prior Art Investigation Framework

Provides three tools:
- load_minimal: Q1 + Q6 framework (Requirements phase, ~150 tokens)
- load_full: Q1-Q7 framework (Design phase, ~500 tokens)
- load_selector: Auto-routes to minimal/full based on phase detected
"""

import sys
from pathlib import Path
from typing import Any

try:
    from mcp.server.fastmcp import FastMCP
except ImportError:
    # Fallback for simpler MCP implementations
    print("Warning: FastMCP not available, using basic server", file=sys.stderr)
    sys.exit(1)

# Get repo root (relative to this script)
REPO_ROOT = Path(__file__).parent.parent
PROMPTS_DIR = REPO_ROOT / "docs" / "en" / "github" / "prompts"

# Initialize MCP Server
mcp = FastMCP("prior-art-investigation")


def load_prompt_file(filename: str) -> str:
    """Load prompt file content, handle multiple languages."""
    file_path = PROMPTS_DIR / filename
    if not file_path.exists():
        # Try Japanese version if English not found
        file_path = REPO_ROOT / "docs" / "ja" / "github" / "prompts" / filename
    
    if not file_path.exists():
        raise FileNotFoundError(f"Prompt file not found: {filename}")
    
    return file_path.read_text(encoding="utf-8")


@mcp.tool()
def load_minimal() -> str:
    """
    Load MINIMAL prompt (Q1+Q6 only, Requirements phase).
    
    Framework: Q1 + Q6 only
    Time: 5-10 minutes
    Tokens: ~150
    Use when: Quick feature validation, feasibility check
    """
    return load_prompt_file("minimal.prompt.md")


@mcp.tool()
def load_full() -> str:
    """
    Load FULL prompt (Q1-Q7, Design phase).
    
    Framework: Q1-Q7 complete investigation
    Time: 20-40 minutes
    Tokens: ~500
    Use when: Architecture decisions, new subsystem design
    """
    return load_prompt_file("full.prompt.md")


@mcp.tool()
def load_selector() -> str:
    """
    Load SELECTOR prompt (auto-routes to minimal/full).
    
    Asks: "What phase are you in?"
    Routes to: minimal (Requirements) or full (Design/Tasks)
    Time: 1-2 minutes
    Tokens: ~100
    Use when: Unsure which prompt to start with
    """
    return load_prompt_file("selector.prompt.md")


if __name__ == "__main__":
    mcp.run()
