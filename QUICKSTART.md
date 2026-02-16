# Quick Start Guide - Mana Prayanam

## 🚀 Quick Setup (After Node.js is installed)

### Option 1: Using Batch Files (Easiest)

1. **Double-click `setup.bat`** to install all dependencies
2. **Double-click `start-app.bat`** to run the application

### Option 2: Using PowerShell

1. Right-click `setup.ps1` → Run with PowerShell
2. Right-click `start-app.ps1` → Run with PowerShell

### Option 3: Manual Commands

**Setup:**
```bash
# In backend folder
cd backend
npm install

# In frontend folder
cd frontend
npm install
```

**Run:**
```bash
# Terminal 1 - Backend
cd backend
npm start

# Terminal 2 - Frontend
cd frontend
npm start
```

## 📋 Prerequisites

1. **Node.js** - Download and install from: https://nodejs.org
   - After installation, restart your terminal
   - Verify: `node --version` and `npm --version`

2. **MongoDB** - Choose one option:
   - **Option A (Local):** Download from https://www.mongodb.com/try/download/community
   - **Option B (Cloud - Recommended):** Use MongoDB Atlas (free): https://www.mongodb.com/cloud/atlas

3. **Update MongoDB Connection**
   - Edit `backend\.env` file
   - Update `MONGODB_URI` with your connection string

## 🌐 Access the Application

Once both servers are running:
- **Frontend:** http://localhost:3000 (Opens automatically)
- **Backend API:** http://localhost:5000

## 🛠️ Troubleshooting

### Node.js not found
- Make sure Node.js is installed
- Restart your terminal/PowerShell after installation
- Check PATH environment variable includes Node.js

### MongoDB connection error
- Make sure MongoDB is running on localhost:27017
- Or update `.env` file with MongoDB Atlas connection string

### Port already in use
- Backend (5000): Stop any other app using port 5000
- Frontend (3000): Stop any other app using port 3000

## 📁 Project Structure

```
ride-share-app/
├── setup.bat           # Windows setup script
├── setup.ps1           # PowerShell setup script
├── start-app.bat       # Windows start script
├── start-app.ps1       # PowerShell start script
├── backend/            # Express.js API
├── frontend/           # React application
└── demo.html           # Standalone demo page
```

## 💡 Features

✅ User Authentication (Register/Login)
✅ Find Available Rides
✅ Offer Your Ride
✅ Book Rides
✅ User Profile Management
✅ Environmental Impact Tracking
✅ Cost Savings Calculator

---

**Mana Prayanam: Save Natural Resources** 🌱
