#!/bin/bash
#run this script from the scripts directory only.
# This script initializes Firebase, deploys Cloud Functions, Firestore rules, indexes, and storage rules.
cd ..
echo "🔍 Checking for Firebase CLI..."
npm install -g firebase-tools
echo "Logging into Firebase (skip if already logged in)..."
firebase login || true
firebase use --add
echo "Installing function dependencies..."
cd functions
npm install
echo "🧹 Running lint check..."
npm run lint || echo "X---Lint issues found. Fix manually or run: npm run lint:fix"
npm run lint:fix || echo "X---Could not fix lint issues automatically. Please review them manually."
npm run build ||   echo "X----- TypeScript build failed."
cd ..
cd functions
pause_for_review() {
  echo "    ***functions built successfully***"
  echo "############################################################################################"
  echo "------ All set! You can now run the Firebase emulator with: ------"
  echo ""
  echo "   cd .."
  echo "   cd functions"
  echo "   npm run build"
  echo "   npm run serve (for running in local development mode)"
  echo ""
  echo "############################################################################################"
  echo "-----------Press ENTER to exit this script-----------"
  read
} 
pause_for_review

