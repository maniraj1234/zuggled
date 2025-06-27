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
firebase login 
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

### **Scripts for set-up and deploy**
Make sure you are in Scripts directory before running these scripts
1. set-up firebase and run the emulator: 
```sh
./setup.sh
```
2. deploy the cloud functions: 
```sh
./deploy.sh
```