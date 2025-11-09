# ELEVATE Knowledge Base

This directory contains the AI knowledge base for the intelligent ELEVATE update system.

## Structure

```
.elevate-knowledge/
├── patterns.json           # iOS adaptation patterns database
├── templates/              # Swift code generation templates
├── cache/                  # Cached analysis results
└── README.md              # This file
```

## Pattern Database

The `patterns.json` file contains documented iOS adaptation patterns learned from the codebase. Each pattern includes:

- **ID**: Unique identifier
- **Category**: Pattern classification (layout, interaction, accessibility, etc.)
- **ELEVATE Pattern**: Web/React pattern from ELEVATE Core UI
- **iOS Adaptation**: How we adapt it for iOS/SwiftUI
- **Confidence**: Success rate (0.0-1.0)
- **Examples**: Real code examples from the codebase
- **Template**: Associated code generation template

## Current Patterns (6)

1. **icon-positioning** (95%): Dynamic icon placement with enum-based layout
2. **hover-state-removal** (98%): Converting hover states to press gestures
3. **touch-target-expansion** (99%): Ensuring 44pt minimum touch targets
4. **typography-scaling** (100%): iOS 1.25x scaling with formula transparency
5. **color-dark-mode** (97%): Adaptive color with @Environment colorScheme
6. **dropdown-native-picker** (92%): Native iOS picker instead of custom dropdown

## Usage

The knowledge base is automatically used by:
- `scripts/analyze-elevate-changes.py` - Pattern matching during change detection
- Future: `scripts/generate-ios-adaptation.py` - Auto-code generation
- Future: ML model training for pattern recognition

## Adding New Patterns

When you discover a new iOS adaptation pattern:

1. Document it in `patterns.json`:
   ```json
   {
     "id": "pattern-name",
     "category": "category",
     "elevate_pattern": "Description of ELEVATE web pattern",
     "ios_adaptation": {
       "approach": "How we solve it on iOS",
       "code_pattern": "Code template"
     },
     "confidence": 0.85,
     "examples": ["File.swift:123-145"]
   }
   ```

2. Create a template in `templates/pattern-name.swift.jinja2`
3. Run validation: `./scripts/elevate-update.sh status`

## Pattern Confidence Levels

- **0.90-1.00**: Proven pattern, safe for auto-generation
- **0.70-0.89**: Established pattern, requires review
- **0.50-0.69**: Emerging pattern, manual implementation
- **<0.50**: Experimental, document only

## Maintenance

The knowledge base should be updated:
- After each ELEVATE version update
- When discovering new iOS adaptation patterns
- When refactoring existing components
- When HIG guidelines change

Last updated: 2025-11-09
