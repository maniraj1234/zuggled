# 🏗️ Backend 
Uses Express.js for API handling. 

### **1️⃣ Installation**
Clone the repository and install dependencies:
```sh
git clone https://github.com/maniraj1234/zugg
cd backend
npm install
```

### **2️⃣ Run in Development Mode (Auto-restart on File Changes)**
```sh
npm run dev
```

### **3️⃣ Run the Server**
1. Build the project:
- compiles Typescript source code (.ts) code to Javascript (.js) which is placed at build/ directory.
```sh
npm run build
```
2. Start the complied server using:
```sh
npm start
```

### **4️⃣ Linting**
This project uses ESLint for maintaining code quality.
Check for linting errors and issues:
```sh
npm run lint
```

### **5️⃣ Environment Variables**
Create a `.env` file at 'backend/config/'

### **6️⃣ Configure Base URL in Frontend**

In your Flutter project, update the API base URL to point to your backend server:
- open `.env` file located at `lib/core/config/`. 
- Set the `BASE_URL` to your local IP address or deployed server URL. For example:
```env
BASE_URL=http://192.168.1.100:3000