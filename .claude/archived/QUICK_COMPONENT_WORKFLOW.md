# Quick Component Development Workflow

## TL;DR - Prevent Build Breakage

**Rule:** All in-development components MUST use `.wip` extension until fully working.

---

## Add New Component (3 Steps)

### 1. Create Token File (WIP)
```bash
cd ElevateUI/Sources/DesignTokens/Components/
touch NewComponentTokens.swift.wip
```

### 2. Create Component File (WIP)
```bash
cd ElevateUI/Sources/SwiftUI/Components/
touch ElevateNewComponent+SwiftUI.swift.wip
```

### 3. Develop & Test
- Edit `.wip` files
- When ready to test: `mv file.wip file.swift`
- If breaks: `mv file.swift file.wip`
- When stable: keep as `.swift`

---

## Fix Broken Component (1 Command)

```bash
# Quick disable
mv BrokenComponent.swift BrokenComponent.swift.wip
mv BrokenTokens.swift BrokenTokens.swift.wip
```

---

## Current Status

### Working Components
```
✅ ElevateButton+SwiftUI.swift
✅ ElevateBadge+SwiftUI.swift
✅ ElevateChip+SwiftUI.swift
✅ ButtonTokens.swift
✅ BadgeTokens.swift
✅ ChipTokens.swift
```

### In Development (WIP)
```
🚧 ElevateRadio+SwiftUI.swift.wip
```

### Disabled (Need Token Fixes)
```
⚠️ CheckboxTokens.swift.disabled
⚠️ SwitchTokens.swift.disabled
⚠️ RadioTokens.swift.disabled
⚠️ ElevateCheckbox+SwiftUI.swift.disabled
⚠️ ElevateSwitch+SwiftUI.swift.disabled
```

---

## Reactivate Disabled Component

1. Fix token generation issues
2. Rename:
```bash
mv CheckboxTokens.swift.disabled CheckboxTokens.swift
mv ElevateCheckbox+SwiftUI.swift.disabled ElevateCheckbox+SwiftUI.swift
```
3. Test build
4. If fails, re-disable immediately

---

## Why This Works

- **Xcode ignores `.wip` files** - Won't break builds
- **Clear visual indicator** - Know what's in development
- **One rename to activate** - No code changes needed
- **Quick rollback** - Just rename back

---

## Template for Claude

When implementing a new component, tell Claude:

> "Implement `NewComponent` but create files with `.wip` extension so they don't break the build. Follow the QUICK_COMPONENT_WORKFLOW.md"

This ensures:
- ✅ Files created with `.wip` extension
- ✅ Build stays working
- ✅ Can develop incrementally
- ✅ Easy to activate when ready
