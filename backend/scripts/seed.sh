#!/bin/bash

echo "🔄 Running Firestore Seeder..."

# Navigate to functions folder if needed
cd ..
cd functions

# Run the TypeScript seed script
npx ts-node src/scripts/seed.ts

echo 
pause_for_review() {
  echo ""
  echo "✅ Seeding finished."
  echo ""
  echo "----------- Press ENTER to exit this script -----------"
  read
}

# ⏸️ Pause to let user read the message
pause_for_review
