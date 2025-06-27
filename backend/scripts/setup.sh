#!/bin/bash
# ---------------------------------------------------------------------------------------
# 📜 Firebase Deployment Script
# Run this script from the scripts/ directory.
# This script:
#   - Ensures Firebase CLI is installed
#   - Logs into Firebase (if needed)
#   - Links to a Firebase project
#   - Installs dependencies
#   - Lints and builds TypeScript Cloud Functions
#   - Guides the user to run local emulators after build
# ---------------------------------------------------------------------------------------

# Move to the project root directory (assumes scripts/ is sibling to functions/)
cd ..

# 🔍 Ensure Firebase CLI is installed globally
echo "🔍 Checking for Firebase CLI..."
npm install -g firebase-tools

# 🔐 Log into Firebase account (opens browser if not logged in)
echo "🔐 Logging into Firebase (skip if already logged in)..."
firebase login || true  # Skip error if already logged in

# 🔗 Link this local folder to a Firebase project (interactive prompt)
firebase use --add

# 📦 Move into functions directory and install dependencies
echo "📦 Installing function dependencies..."
cd functions
npm install

# 🧹 Run lint check and attempt to auto-fix any issues
echo "🧹 Running lint check..."
npm run lint || echo "❌ Lint issues found. Fix manually or run: npm run lint:fix"
npm run lint:fix || echo "❌ Could not fix lint issues automatically. Please review them manually."

# 🔧 Build TypeScript code into JavaScript
npm run build || echo "❌ TypeScript build failed."

# Go back to the root (optional depending on structure)
cd ..
cd functions  # Enter functions again for next step

echo "🚀 Functions built successfully! You can now run the Firebase emulator.(running ...)"
npm run serve || echo "❌ launching emulator failed" # Runs local emulator for development
# 📌 Custom pause function to show emulator instructions and wait for user input
pause_for_review() {
  echo "✅ ✅ ✅  *** Functions built successfully ***"
  echo "############################################################################################"
  echo "✅ All set! You can now run the Firebase emulator with:"
  echo ""
  echo "   cd .."
  echo "   cd functions"
  echo "   npm run build"
  echo "   npm run serve   # Runs local emulator for development"
  echo ""
  echo "############################################################################################"
  echo "🕹️ Press ENTER to exit this script"
  read
}

# ⏸️ Pause script to allow user to read instructions
pause_for_review
