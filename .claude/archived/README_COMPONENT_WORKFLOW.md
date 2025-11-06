# Component Development Workflow - README

## The Problem We Solved

**Before:** Adding new components broke the entire build, requiring manual file disabling and wasting development time.

**Now:** Use `.wip` file extensions to isolate in-development work from stable code.

---

## The Solution (One Line)

**All new/incomplete components use `.wip` extension - Xcode won't compile them.**

---

## Quick Start

### Adding a New Component

```bash
# 1. Create files with .wip extension
touch ElevateUI/Sources/DesignTokens/Components/NewTokens.swift.wip
touch ElevateUI/Sources/SwiftUI/Components/ElevateNew+SwiftUI.swift.wip

# 2. Develop in .wip files (build won't break)

# 3. When ready to activate:
mv NewTokens.swift.wip NewTokens.swift
mv ElevateNew+SwiftUI.swift.wip ElevateNew+SwiftUI.swift

# 4. If something breaks, instant rollback:
mv NewTokens.swift NewTokens.swift.wip
mv ElevateNew+SwiftUI.swift ElevateNew+SwiftUI.swift.wip
```

---

## Current Component Status (2024-11-04)

### ✅ Stable & Working
- ElevateButton (SwiftUI + UIKit)
- ElevateBadge (SwiftUI + UIKit)
- ElevateChip (SwiftUI + UIKit)

### 🚧 In Development (.wip)
- ElevateRadio+SwiftUI.swift.wip

### ⚠️ Disabled (Broken Token Definitions)
- CheckboxTokens.swift.disabled
- SwitchTokens.swift.disabled
- RadioTokens.swift.disabled
- ElevateCheckbox+SwiftUI.swift.disabled
- ElevateSwitch+SwiftUI.swift.disabled

---

## For Future Claude Sessions

When asked to implement a new component:

**YOU MUST:**
1. Create all files with `.wip` extension
2. Never commit breaking code
3. Test independently before activation

**Example prompt:**
> "Implement ElevateSlider component. Create files with `.wip` extension following QUICK_COMPONENT_WORKFLOW.md"

---

## File Extensions Explained

| Extension | Meaning | Compiled? |
|-----------|---------|-----------|
| `.swift` | Stable, working code | ✅ Yes |
| `.swift.wip` | Work in progress | ❌ No |
| `.swift.disabled` | Broken, needs fixing | ❌ No |

---

## Fixing Disabled Components

The `.disabled` components need their token definitions fixed:

1. Check generated token files in `DesignTokens/Generated/`
2. Verify token properties match component expectations
3. Fix mismatches in token wrapper files
4. Rename `.disabled` → `.swift`
5. Test build
6. If fails, rename back to `.disabled`

---

## Benefits

✅ **No more build breakage** - WIP code is isolated
✅ **Faster development** - Test incrementally without breaking production
✅ **Clear status** - File extension shows component state
✅ **Easy rollback** - Just rename the file
✅ **Less token waste** - No more debugging broken builds

---

## See Also

- `COMPONENT_DEVELOPMENT_GUIDE.md` - Detailed methodology
- `QUICK_COMPONENT_WORKFLOW.md` - Quick reference commands

---

## Build Status

**Last successful build:** 2024-11-04
**Xcode version:** 26.1
**iOS deployment target:** 26.1
**Working components:** 3 (Button, Badge, Chip)
