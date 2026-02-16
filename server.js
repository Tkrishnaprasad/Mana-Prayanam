const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const dotenv = require('dotenv');
const http = require('http');
const { Server } = require('socket.io');

dotenv.config();

const app = express();
const server = http.createServer(app);

// Socket.io setup - free real-time communication
const io = new Server(server, {
  cors: {
    origin: [
      'http://localhost:3000', 
      'http://localhost:3001',
      process.env.CLIENT_URL || '*' // Allow production client or all for dev
    ],
    methods: ['GET', 'POST']
  }
});

// Middleware
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ limit: '10mb', extended: true }));

// Debug middleware to log all requests
app.use((req, res, next) => {
  if (req.body && Object.keys(req.body).length > 0) {
    console.log(`📨 ${req.method} ${req.path}`, req.body);
  }
  next();
});

// Make io accessible to routes
app.set('io', io);

// Socket.io connection handling
const onlineUsers = new Map(); // userId -> socketId

io.on('connection', (socket) => {
  console.log('🔌 User connected:', socket.id);

  // User joins with their userId
  socket.on('user:join', (userId) => {
    onlineUsers.set(userId, socket.id);
    socket.userId = userId;
    console.log(`👤 User ${userId} online`);
  });

  // Join a ride room for group/ride-specific chat
  socket.on('ride:join', (rideId) => {
    socket.join(`ride:${rideId}`);
    console.log(`🚗 User joined ride room: ${rideId}`);
  });

  // Leave ride room
  socket.on('ride:leave', (rideId) => {
    socket.leave(`ride:${rideId}`);
  });

  // Real-time messaging
  socket.on('message:send', async (data) => {
    const { rideId, recipientId, message, senderName, senderId } = data;
    
    // Emit to ride room (all participants see it)
    io.to(`ride:${rideId}`).emit('message:new', {
      rideId,
      sender: { _id: senderId, name: senderName },
      recipient: recipientId,
      message,
      createdAt: new Date().toISOString()
    });

    // Also emit directly to recipient if they're online but not in room
    const recipientSocket = onlineUsers.get(recipientId);
    if (recipientSocket) {
      io.to(recipientSocket).emit('message:notification', {
        rideId,
        senderName,
        message: message.substring(0, 50)
      });
    }
  });

  // Typing indicator
  socket.on('typing:start', ({ rideId, userName }) => {
    socket.to(`ride:${rideId}`).emit('typing:show', { userName });
  });

  socket.on('typing:stop', ({ rideId }) => {
    socket.to(`ride:${rideId}`).emit('typing:hide');
  });

  // Ride status updates (broadcast to ride participants)
  socket.on('ride:statusUpdate', ({ rideId, status, driverName }) => {
    io.to(`ride:${rideId}`).emit('ride:statusChanged', { rideId, status, driverName });
  });

  socket.on('disconnect', () => {
    if (socket.userId) {
      onlineUsers.delete(socket.userId);
    }
    console.log('🔌 User disconnected:', socket.id);
  });
});

// MongoDB Connection
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/ride-share-db', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  serverSelectionTimeoutMS: 5000
})
.then(() => console.log('✓ MongoDB connected successfully'))
.catch(err => {
  console.error('❌ MongoDB connection error:', err.message);
  console.error('Please ensure:');
  console.error('  1. Your IP is whitelisted in MongoDB Atlas (Network Access)');
  console.error('  2. Connection string is correct in .env file');
});

// Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/rides', require('./routes/rides'));
app.use('/api/ratings', require('./routes/ratings'));
app.use('/api/messages', require('./routes/messages'));
app.use('/api/payments', require('./routes/payments'));
app.use('/api/users', require('./routes/users'));
app.use('/api/notifications', require('./routes/notifications'));

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'Server is running', socketConnections: onlineUsers.size });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Internal server error' });
});

const PORT = process.env.PORT || 5000;
server.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`🔌 Socket.io ready for real-time chat`);
});

module.exports = { app, io };
