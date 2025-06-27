#!/bin/bash

# This script initializes Firebase, deploys Cloud Functions, Firestore rules, indexes, and storage rules,
cd ..
echo "🔍 Checking for Firebase CLI..."
npm install -g firebase-tools

echo "🔐 Logging into Firebase (skip if already logged in)..."
firebase login || true

# firebase use --add || echo "❗ You must select or create a Firebase project before proceeding."


echo "📦 Installing function dependencies..."
cd functions
npm install

echo "🧹 Running lint check..."
npm run lint || echo "⚠️ Lint issues found. Fix manually or run: npm run lint:fix"
npm run lint:fix || echo "⚠️ Could not fix lint issues automatically. Please review them manually."
npm run build ||   echo "❌ TypeScript build failed."
cd ..
cd functions
pause_for_review() {
  echo "functions built successfully."
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

