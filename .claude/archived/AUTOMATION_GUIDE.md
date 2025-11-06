# ElevateUI Automation Guide

## One-Command Update

The entire ELEVATE UI update workflow can now be executed with a **single command**:

```bash
./scripts/update-elevate-ui.sh --remote
```

This will automatically:
1. ✅ Fetch the latest ELEVATE Core UI design tokens from GitHub
2. ✅ Regenerate all Swift token files (Primitives, Aliases, Components)
3. ✅ Build the ElevateUI package
4. ✅ Run all tests
5. ✅ Report success or actionable errors
6. ✅ Cache results to avoid unnecessary rebuilds

---

## Usage

### Basic Update (Remote Fetch)

Fetch tokens from GitHub and update:

```bash
./scripts/update-elevate-ui.sh --remote
```

**Output Example:**
```
╔════════════════════════════════════════════════════════════╗
║         ELEVATE UI Complete Update Script v1.0             ║
╚════════════════════════════════════════════════════════════╝

▶ Step 1: Fetching ELEVATE Design Tokens
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ℹ Fetching tokens from GitHub (remote mode)...
✓ Tokens fetched from GitHub

▶ Step 2: Checking if Update Needed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ℹ Current token hash: a3f2b8c9d...
ℹ Changes detected
✓ Update needed

▶ Step 3: Regenerating Swift Token Files
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Token files regenerated successfully
ℹ Generated 635 tokens across 5 files

▶ Step 4: Building ElevateUI Package
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Build succeeded
ℹ Build time: 0.54s

▶ Step 5: Running Tests
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ All tests passed
ℹ Tests passed: 6

▶ Step 6: Updating Cache
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Cache updated

╔════════════════════════════════════════════════════════════╗
║                  ✓ UPDATE SUCCESSFUL                       ║
╚════════════════════════════════════════════════════════════╝

✓ ElevateUI updated successfully
ℹ Total time: 15s
```

### Using Local Tokens

If you have a local clone of the ELEVATE tokens repository:

```bash
export ELEVATE_TOKENS_PATH="/path/to/elevate-design-tokens/src/scss"
./scripts/update-elevate-ui.sh
```

### Skip Tests (Faster, Not Recommended)

```bash
./scripts/update-elevate-ui.sh --remote --skip-tests
```

### Force Update (Ignore Cache)

```bash
./scripts/update-elevate-ui.sh --remote --force
```

---

## Command Options

| Option | Description |
|--------|-------------|
| `--remote` | Fetch tokens from GitHub instead of using local clone |
| `--skip-tests` | Skip running tests (faster, but not recommended for production) |
| `--force` | Force update even if no changes detected (ignore cache) |
| `--help` | Show help message with all options |

---

## Update Workflow Details

### Step 1: Fetch Tokens

**Remote Mode** (`--remote`):
- Clones the latest ELEVATE tokens from GitHub
- Uses temporary directory (`/tmp/elevate-tokens-*`)
- Automatically cleaned up after completion
- No need for local token repository

**Local Mode** (default):
- Uses existing local token repository
- Requires `ELEVATE_TOKENS_PATH` environment variable
- Faster if you already have tokens cloned
- Useful for development/testing

### Step 2: Change Detection

- Computes SHA-256 hash of token files
- Compares with cached hash (`.elevate-token-cache.json`)
- Skips regeneration if tokens haven't changed
- Saves time and prevents unnecessary builds
- Use `--force` to bypass cache

### Step 3: Token Generation

- Runs `scripts/update-design-tokens-v3.py`
- Generates 635 tokens across 5 files:
  - ElevatePrimitives.swift (62 tokens)
  - ElevateAliases.swift (279 tokens)
  - ButtonComponentTokens.swift (113 tokens)
  - ChipComponentTokens.swift (156 tokens)
  - BadgeComponentTokens.swift (25 tokens)
- Uses `Color.adaptive()` for native light/dark mode support
- Maintains proper three-tier hierarchy

### Step 4: Build Verification

- Runs `swift build` to ensure no compilation errors
- Reports build time and any errors
- Provides helpful error messages for common issues
- Fails fast if build errors occur

### Step 5: Test Execution

- Runs `swift test` to verify functionality
- Ensures no regressions introduced
- Reports number of tests passed
- Can be skipped with `--skip-tests` for faster iterations

### Step 6: Cache Update

- Saves hash of current tokens
- Includes timestamp and version info
- Used for change detection on next run
- Located at `.elevate-token-cache.json`

---

## Cache File Format

`.elevate-token-cache.json`:
```json
{
  "hash": "a3f2b8c9d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1",
  "timestamp": "2025-11-04T18:30:00Z",
  "elevate_version": "latest",
  "script_version": "v3.2"
}
```

---

## Error Handling

The script provides helpful error messages for common issues:

### Missing Dependencies
```
✗ Missing required dependencies: python3 swift git
```
**Fix**: Install missing tools with Homebrew or package manager

### Token Path Not Set
```
✗ ELEVATE_TOKENS_PATH not set and --remote not specified
```
**Fix**: Either use `--remote` or set `ELEVATE_TOKENS_PATH`

### Build Failures
```
✗ Build failed
⚠ Found references to old DynamicColor - may need manual migration
```
**Fix**: Check build output for specific errors

### Test Failures
```
✗ Tests failed
```
**Fix**: Review test output and fix failing tests before committing

---

## Integration with Development Workflow

### Daily Development

Check for updates before starting work:
```bash
./scripts/update-elevate-ui.sh --remote
```

### Before Committing

Ensure everything builds and tests pass:
```bash
./scripts/update-elevate-ui.sh --force
```

### CI/CD Pipeline

Add to `.github/workflows/update-tokens.yml`:
```yaml
- name: Update ELEVATE UI
  run: ./scripts/update-elevate-ui.sh --remote
```

### Pre-Commit Hook

Add to `.git/hooks/pre-commit`:
```bash
#!/bin/bash
./scripts/update-elevate-ui.sh --skip-tests
```

---

## Performance

### Typical Execution Times

| Scenario | Time | Notes |
|----------|------|-------|
| **No changes** | ~2s | Cache hit, skips regeneration |
| **Remote fetch + update** | ~15s | Full workflow with tests |
| **Local update** | ~10s | Faster without git clone |
| **Skip tests** | ~8s | Not recommended for production |

### What Takes Time

- **Git clone** (~3-5s): Fetching from GitHub
- **Token generation** (~1-2s): Parsing SCSS, generating Swift
- **Build** (~5-7s): Swift compilation
- **Tests** (~2-3s): Running test suite

---

## Troubleshooting

### Script Won't Run

```bash
# Make sure it's executable
chmod +x scripts/update-elevate-ui.sh

# Run with bash explicitly
bash scripts/update-elevate-ui.sh --remote
```

### Python Not Found

```bash
# Install Python 3
brew install python3

# Or use system Python
/usr/bin/python3
```

### Permission Denied on Cache

```bash
# Remove old cache and try again
rm .elevate-token-cache.json
./scripts/update-elevate-ui.sh --remote
```

### Build Errors After Update

If you get build errors after a token update:

1. **Check for renamed tokens**: ELEVATE may have renamed some tokens
2. **Review component wrappers**: ButtonTokens, ChipTokens, BadgeTokens may need updates
3. **Check migration notes**: Look for breaking changes in ELEVATE changelog

Common fixes:
```bash
# Force clean build
swift package clean
./scripts/update-elevate-ui.sh --remote --force
```

---

## Advanced Usage

### Update Specific Component

The script updates all tokens, but you can manually run just the generation:

```bash
python3 scripts/update-design-tokens-v3.py
swift build
```

### Compare Token Changes

See what changed:
```bash
# Before update
git status

# After update
git diff ElevateUI/Sources/DesignTokens/Generated/
```

### Rollback Changes

If update causes issues:
```bash
git checkout ElevateUI/Sources/DesignTokens/Generated/
rm .elevate-token-cache.json
```

---

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `ELEVATE_TOKENS_PATH` | Path to local ELEVATE tokens SCSS directory | Required if not using `--remote` |
| `ELEVATE_TOKENS_REPO` | GitHub repository URL | `https://github.com/inform-elevate/elevate-design-tokens.git` |
| `ELEVATE_TOKENS_BRANCH` | Branch to fetch | `main` |

Override defaults:
```bash
export ELEVATE_TOKENS_REPO="https://github.com/your-fork/elevate-design-tokens.git"
export ELEVATE_TOKENS_BRANCH="develop"
./scripts/update-elevate-ui.sh --remote
```

---

## GitHub Actions Integration

For automated updates, see `.github/workflows/update-tokens.yml` (to be created).

The workflow will:
- Run daily at 2 AM UTC
- Check for ELEVATE token updates
- Create PR if changes detected
- Run full test suite
- Auto-label with "dependencies"

---

## Best Practices

### 1. Always Test Before Committing
```bash
./scripts/update-elevate-ui.sh --remote
git add .
git commit -m "Update ELEVATE tokens to latest"
```

### 2. Use Remote Mode in CI/CD
```yaml
# Always fetch fresh tokens in CI
run: ./scripts/update-elevate-ui.sh --remote
```

### 3. Don't Skip Tests in Production
```bash
# ✅ Good for development
./scripts/update-elevate-ui.sh --remote --skip-tests

# ✅ Good for production
./scripts/update-elevate-ui.sh --remote
```

### 4. Review Changes Before Pushing
```bash
./scripts/update-elevate-ui.sh --remote
git diff  # Review what changed
git add .
git commit
```

### 5. Keep Cache File in .gitignore
```bash
echo ".elevate-token-cache.json" >> .gitignore
```

---

## What's Next

This automation script lays the groundwork for even more automation:

### Planned Enhancements
- [ ] GitHub Actions workflow for automatic PRs
- [ ] Slack/Discord notifications on updates
- [ ] Semantic versioning based on token changes
- [ ] Visual regression testing integration
- [ ] Automatic changelog generation

---

## Summary

**One command to rule them all:**
```bash
./scripts/update-elevate-ui.sh --remote
```

This script eliminates the manual workflow and ensures:
- ✅ Always using latest ELEVATE tokens
- ✅ No build errors slip through
- ✅ Tests validate everything works
- ✅ Cache prevents unnecessary work
- ✅ Clear error messages for debugging

**Result**: Seamless ELEVATE UI updates with zero manual steps! 🚀
