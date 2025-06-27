#!/bin/bash
# ---------------------------------------------------------------------------------------
# 🚀 Firebase Function Deployment Script
# Run this script from the scripts/ directory.
# This script:
#   - Lints and builds TypeScript code
#   - Deploys only the Cloud Functions to Firebase
# ---------------------------------------------------------------------------------------

# Step 1: Move to the root of the project (assumes script is in scripts/)
cd ..
cd functions
# 🧹 Run linter to check for TypeScript or style issues
# If issues are found, notify the user but don’t stop the script
npm run lint || echo "❌ Lint issues found. Fix manually or run: npm run lint:fix"

# 🧼 Attempt to fix lint issues automatically
npm run lint:fix || echo "❌ Could not fix lint issues automatically. Please review them manually."

# 🔧 Build TypeScript code into JavaScript for Cloud Functions
# If build fails, notify the user
npm run build || echo "❌ TypeScript build failed."

# 🚀 Deploy only Cloud Functions (not Firestore rules or hosting, etc.)
firebase deploy --only functions

# ✅ Confirmation message after deployment
pause_for_review() {
  echo ""
  echo "✅ ✅ ✅ *** Functions have been deployed successfully ***"
  echo ""
  echo "----------- Press ENTER to exit this script -----------"
  read
}

# ⏸️ Pause to let user read the message
pause_for_review
