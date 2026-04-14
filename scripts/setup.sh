#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Prior Art Investigation Setup${NC}"
echo ""

# Detect language
if [ -z "$LANGUAGE" ]; then
  echo -e "${YELLOW}Select language / 言語を選択:${NC}"
  echo "1) English"
  echo "2) 日本語"
  read -p "Enter choice (1 or 2): " lang_choice
  
  case $lang_choice in
    1) LANGUAGE="en" ;;
    2) LANGUAGE="ja" ;;
    *) echo -e "${RED}Invalid choice${NC}"; exit 1 ;;
  esac
fi

LANG_DIR=$LANGUAGE
echo -e "${GREEN}✓ Language: $LANGUAGE${NC}"
echo ""

# Check if Kiro project
if [ ! -d ".kiro/settings" ]; then
  echo -e "${YELLOW}Warning: .kiro/settings not found. Creating...${NC}"
  mkdir -p .kiro/settings/{rules,templates/specs}
fi

# Determine source
if [ -d "node_modules/@ma2tani/prior-art-investigation" ]; then
  SOURCE_DIR="node_modules/@ma2tani/prior-art-investigation"
  echo -e "${GREEN}✓ Using npm package${NC}"
else
  SOURCE_DIR="."
  echo -e "${GREEN}✓ Using local files${NC}"
fi

echo ""
echo -e "${YELLOW}Copying files...${NC}"

# Copy Kiro files
cp "$SOURCE_DIR/docs/$LANG_DIR/kiro/settings/rules/oss-evaluation.md" .kiro/settings/rules/
echo -e "${GREEN}✓ Copied oss-evaluation.md${NC}"

cp "$SOURCE_DIR/docs/$LANG_DIR/templates/research.md" .kiro/settings/templates/specs/
echo -e "${GREEN}✓ Copied research.md template${NC}"

# Optional: copy prompt
if mkdir -p .github/prompts 2>/dev/null; then
  cp "$SOURCE_DIR/docs/$LANG_DIR/github/prompts/prior-art-check.prompt.md" .github/prompts/
  echo -e "${GREEN}✓ Copied prior-art-check.prompt${NC}"
fi

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Read setup-checklist: docs/$LANG_DIR/setup-checklist.md"
echo "2. Use research.md template in .kiro/specs/ for your next feature"
echo "3. Run: /kiro-spec-requirements to start design phase"
echo ""
