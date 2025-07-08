# 🏗️ Backend – Firebase Cloud Functions (Express.js + TypeScript)

**Zuggled** uses **Firebase Cloud Functions** and **Express.js** to serve APIs. It is written in **TypeScript** and deployed serverlessly using Firebase.

---

### **1️⃣ Installation**
Clone the repository:
```sh
git clone https://github.com/maniraj1234/zuggled
cd zuggled/backend/functions
npm install
```
Setting up firebase: 
```sh
npm install -g firebase-tools #install the firebase CLI
firebase login #log into firebase
firebase init #initialise and select the firebase project
```

### **⚙️2️⃣ Run in Development Mode (Local Emulator)**
Use the Firebase emulator to test the functions locally:
```sh
npm run serve
```
This command runs firebase emulators:start and uses TypeScript in watch mode (tsc --watch).

### **🔨3️⃣ Build the Functions**
Before deploying, compile your TypeScript code:
```sh
npm run build
```
This places the output .js files in the lib/ directory.

### **🚀4️⃣ Deploy to Firebase**
To deploy your Cloud Functions to Firebase:
```sh
firebase deploy --only functions
```
Ensure your Firebase project is set with:
```sh
firebase use --add
```

### **✅5️⃣ Linting**
To maintain code quality, run:
```sh
npm run lint        # Check for issues
npm run lint:fix    # Automatically fix fixable issues
```

### **🌐6️⃣ Configure API Base URL in Flutter Frontend**
In your Flutter app, update the API base URL:

1. Open: lib/core/config/.env
2. Set your deployed function URL:
```sh
# For production (deployed function)
BASE_URL=https://us-central1-your-project-id.cloudfunctions.net/api

# For local testing with emulator
BASE_URL=http://localhost:5001/your-project-id/us-central1/api
```

### **📜7️⃣ Development Scripts**
Located in the scripts/ directory. Run them from that folder:
1. setup.sh – One-time setup & local testing
```sh
./setup.sh
```
This installs Firebase tools, links the project, installs dependencies, builds the functions, and runs the emulator.
2. deploy.sh – Build & deploy functions
```sh
./deploy.sh
```
Builds the functions and deploys them to Firebase Cloud Functions.


### **🌱8️⃣ Firestore Seeding for Sample Data**
To populate Firestore with sample data (creators, customers, call logs), you can run the seed script locally using the Firebase Admin SDK and a service account.

🔐 Step 1: Setup Service Account Key
To run Firestore seeding locally, you need to authenticate using a Firebase Admin SDK key.
1. Go to your Firebase console → Project settings → Service accounts
2. Click "Generate new private key" and save it
3. Rename the file to serviceAccountKey.json
4. Place it inside the *functions/* directory

🏃‍♂️ Step 2: Run Seeder Script
Use the provided shell script to run the seeder:

```sh
bash scripts/seed.sh
```
This script will compile and run seed.ts located at *functions/src/scripts/* directory
Alternatively, you can run it manually
```sh
npx ts-node src/scripts/seed.ts
```
🧪9️⃣ Verify Seeded Data (Debug Route)
You can verify seeded data by hitting your local emulator endpoint:
```sh
GET http://localhost:5001/<your-project-id>/us-central1/api/creators
```
