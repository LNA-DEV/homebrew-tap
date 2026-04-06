# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Homebrew tap (`LNA-DEV/homebrew-tap`) containing custom formulae for LNA-DEV projects. Formulae are Ruby files in the `Formula/` directory.

## Common Commands

```bash
# Install the tap locally
brew tap LNA-DEV/homebrew-tap

# Test a formula locally
brew install --build-from-source Formula/ytdlp-nfo.rb
brew test ytdlp-nfo

# Audit a formula for style/correctness
brew audit --strict --new Formula/ytdlp-nfo.rb

# Lint Ruby formula files
brew style Formula/ytdlp-nfo.rb
```

## Updating a Formula

When updating a formula for a new release:
1. Update the `url` to point to the new release tarball
2. Update the `sha256` checksum — get it with: `curl -sL <tarball-url> | shasum -a 256`
3. Update the version if it's hardcoded (usually inferred from the URL)

## Formula Structure

Formulae use the standard Homebrew Ruby DSL. The current `ytdlp-nfo` formula uses `Language::Python::Virtualenv` to create an isolated Python environment, install pip dependencies, and symlink the CLI binary.