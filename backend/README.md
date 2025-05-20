# 🏗️ Backend 
Uses Express.js for API handling. 

### **1️⃣ Installation**
Clone the repository and install dependencies:
```sh
git clone https://github.com/maniraj1234/zugg
cd backend
npm install
```
### **2️⃣ Run the Server**
Start the server using:
```sh
npm start
```
### **3️⃣ Run in Development Mode (Auto-restart on File Changes)**
```sh
npm run dev
```
### **4️⃣ Environment Variables**
Create a `.env` file at 'backend/config/'

### **5️⃣ Configure Base URL in Frontend**

In your Flutter project, update the API base URL to point to your backend server:
- open `.env` file located at `lib/core/config/`. 
- Set the `BASE_URL` to your local IP address or deployed server URL. For example:
```env
BASE_URL=http://192.168.1.100:3000