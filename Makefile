.PHONY: setup setup-en setup-ja validate install dev

# Default language: Japanese
LANGUAGE ?= ja

setup:
	@bash scripts/setup.sh

setup-en:
	@LANGUAGE=en bash scripts/setup.sh

setup-ja:
	@LANGUAGE=ja bash scripts/setup.sh

validate:
	@echo "Validating directory structure..."
	@test -f docs/en/README.md && echo "✓ English docs" || (echo "✗ English docs missing"; exit 1)
	@test -f docs/ja/README.md && echo "✓ Japanese docs" || (echo "✗ Japanese docs missing"; exit 1)
	@test -f LICENSE && echo "✓ LICENSE" || (echo "✗ LICENSE missing"; exit 1)
	@echo "✅ All validations passed"

help:
	@echo "Prior Art Investigation Setup"
	@echo ""
	@echo "Usage:"
	@echo "  make setup        - Setup with default language (ja)"
	@echo "  make setup-en     - Setup English version"
	@echo "  make setup-ja     - Setup Japanese version"
	@echo "  make validate     - Validate repository structure"
	@echo "  make help         - Show this help"
