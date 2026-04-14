# MCP Server Setup Guide

## Overview

Prior Art Investigation can be run as an **MCP (Model Context Protocol) Server**, enabling integration with Claude Desktop and other MCP-compatible clients.

> **Status**: MCP server ready for local testing (v1.0.1)  
> **Current version**: v1.0.0 (Markdown-based)  
> **MCP Wrapper**: ✅ Available now  
> **Timeline**: Smithery registry submission in v1.1  

---

## Option 0: Use MCP Server Locally (NEW — v1.0.1)

### Quick Start

1. **Clone the repository**
```bash
git clone https://github.com/ma2tani/prior-art-investigation.git
cd prior-art-investigation
```

2. **Set up MCP server**
```bash
python3 -m venv mcp-env
source mcp-env/bin/activate
pip install -r mcp/requirements.txt
```

3. **Configure Claude Desktop**
   - See: [CLAUDE-DESKTOP-SETUP.md](./CLAUDE-DESKTOP-SETUP.md)
   - Add MCP server config to `~/Library/Application Support/Claude/claude_desktop_config.json`

4. **Restart Claude Desktop**
   - Three MCP tools now available in Claude: `load_minimal`, `load_full`, `load_selector`

---

## Option 1: Use as Markdown Docs (Standalone)

### Quick Start

1. **Clone the repository**
```bash
git clone https://github.com/ma2tani/prior-art-investigation.git
cd prior-art-investigation
```

2. **Read selector prompt**
```bash
cat docs/en/github/prompts/selector.prompt.md
```

3. **Run your investigation**
- Use Claude Desktop, VS Code Copilot, or any Claude client
- Copy the appropriate prompt (MINIMAL or FULL)
- Follow the steps

---

## Option 2: Install via npm (Documentation Distribution)

### Install Package

```bash
npm install @ma2tani/prior-art-investigation
```

### Import Prompts in Your Workflow

```javascript
// JavaScript / TypeScript
import minimalPrompt from '@ma2tani/prior-art-investigation/prompts/minimal';
import fullPrompt from '@ma2tani/prior-art-investigation/prompts/full';
import selectorPrompt from '@ma2tani/prior-art-investigation/prompts/selector';
```

### Access Files Directly

```bash
# From node_modules
cat node_modules/@ma2tani/prior-art-investigation/docs/en/github/prompts/selector.prompt.md
```

---

## Option 3: MCP Server Wrapper (Future — v1.1.0)

**Coming Soon**: Full MCP server implementation using FastMCP.

### When Available

```bash
npm install @ma2tani/prior-art-investigation-mcp
```

### Configure in Claude Desktop

**macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`  
**Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "prior-art": {
      "command": "npm",
      "args": ["-y", "@ma2tani/prior-art-investigation-mcp"]
    }
  }
}
```

### Configure in VS Code Copilot

VS Code Copilot **natively supports MCP servers**. Once the server is running, tools are automatically available.

---

## Integration Patterns

### Pattern 1: Manual Prompt Usage (Now)

**Best for**: Learning phase, one-off investigations

```
1. Install via npm or git clone
2. Copy SELECTOR prompt into your chat
3. Follow the routing decision tree
4. Execute MINIMAL or FULL prompt
5. Document findings
```

**Time**: 5-40 minutes  
**Cost**: ~150-500 tokens  
**Setup**: 2 minutes

---

### Pattern 2: Custom Prompt File (Now)

**Best for**: Integrated workflows, internal projects

```bash
# Option A: Reference from npm package
curl https://raw.githubusercontent.com/ma2tani/prior-art-investigation/main/docs/en/github/prompts/selector.prompt.md > selector.prompt.md

# Option B: Create .agent.md file in VS Code
cat > .vscode/agent-selector.md << 'EOF'
# @vs/code/agent/selector-prior-art
[Copy SELECTOR prompt content here]
EOF
```

---

### Pattern 3: MCP Server Integration (v1.1.0+)

**Best for**: Enterprise workflows, multi-client support

```
1. Install MCP server wrapper
2. Configure in Claude Desktop / VS Code
3. Prompt: "@prior-art investigate [topic]"
4. Server automatically routes to MINIMAL/FULL
5. Results saved to workspace
```

---

## FAQ

### Can I use this without MCP?

**Yes!** Markdown-based usage works with any Claude client. MCP is optional for enterprise workflows.

### Which prompt should I use first?

Use the **SELECTOR** prompt (`docs/en/github/prompts/selector.prompt.md`). It will automatically recommend MINIMAL or FULL based on your phase and time available.

### Can I customize the prompts?

**Yes!**
- **MINIMAL**: Modify to add custom Q1/Q6 variants
- **FULL**: Add Q2-Q5 specialization for your domain
- **SELECTOR**: Adjust routing logic for your workflow

### How does this integrate with Kiro SDD?

The prompts are **fully compatible** with Kiro spec-driven development:

| Kiro Phase | Prompt | Token Budget |
|-----------|--------|--------------|
| Requirements (Phase 1) | MINIMAL | ~150 |
| Design (Phase 2-3) | FULL | ~500 |
| Tasks (Phase 4) | Task Router | ~75 |

---

## Roadmap

### Current (v1.0.0)
- ✅ Markdown-based docs
- ✅ Phase-split prompts (MINIMAL/FULL/SELECTOR)
- ✅ npm distribution
- ✅ Bilingual support (EN/JA)

### Coming Soon (v1.1.0)
- [ ] MCP server wrapper (FastMCP)
- [ ] Docker container
- [ ] Automated token metrics

### Future (v1.2.0+)
- [ ] VS Code Agent Skills template
- [ ] Custom agent personality
- [ ] Smithery registry integration

---

## Support

- **GitHub**: https://github.com/ma2tani/prior-art-investigation
- **Issues**: https://github.com/ma2tani/prior-art-investigation/issues
- **Discussions**: https://github.com/ma2tani/prior-art-investigation/discussions

---

## License

MIT — See [LICENSE](../../LICENSE) for details.
