.PHONY: validate help

validate:
	@echo "Validating directory structure..."
	@test -f README.md && echo "✓ README" || (echo "✗ README.md missing"; exit 1)
	@test -f docs/ja/README.md && echo "✓ Japanese docs" || (echo "✗ Japanese docs missing"; exit 1)
	@test -f docs/en/AGENT-SKILLS-SETUP.md && echo "✓ Agent Skills setup" || (echo "✗ AGENT-SKILLS-SETUP.md missing"; exit 1)
	@test -f docs/en/MCP-SETUP.md && echo "✓ MCP setup" || (echo "✗ MCP-SETUP.md missing"; exit 1)
	@test -f .instructions.md && echo "✓ Agent Skills template" || (echo "✗ .instructions.md missing"; exit 1)
	@test -f mcp/server_lite.py && echo "✓ MCP server" || (echo "✗ MCP server missing"; exit 1)
	@test -f LICENSE && echo "✓ LICENSE" || (echo "✗ LICENSE missing"; exit 1)
	@echo "✅ All validations passed"

help:
	@echo "Prior Art Investigation Framework"
	@echo ""
	@echo "Usage:"
	@echo "  make validate   - Validate repository structure"
	@echo "  make help       - Show this help"
