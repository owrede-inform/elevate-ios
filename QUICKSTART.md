# ElevateUI Quick Start

## Update Everything in One Command

```bash
./scripts/update-elevate-ui.sh --remote
```

That's it! This single command will:
1. ✅ Fetch latest ELEVATE tokens from GitHub
2. ✅ Regenerate all Swift code
3. ✅ Build the package
4. ✅ Run all tests
5. ✅ Report any issues

---

## Common Commands

### Daily Update Check
```bash
./scripts/update-elevate-ui.sh --remote
```

### Force Update (Ignore Cache)
```bash
./scripts/update-elevate-ui.sh --remote --force
```

### Quick Check (Skip Tests)
```bash
./scripts/update-elevate-ui.sh --remote --skip-tests
```

---

## First Time Setup

1. Clone the repository
2. Run: `./scripts/update-elevate-ui.sh --remote`
3. Done!

For full documentation, see `AUTOMATION_GUIDE.md`
