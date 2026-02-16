# Mana Prayanam - Save Natural Resources

A full-stack web application that enables employees to share rides with colleagues going to the same office or direction. This platform helps conserve natural resources, reduce fuel consumption, minimize environmental pollution, and build community among employees.

## Features

✅ **User Authentication** - Secure registration and login system
✅ **Ride Posting** - Drivers can offer rides with seat availability
✅ **Ride Search** - Find available rides based on location and date
✅ **Booking System** - Easy ride booking and cancellation
✅ **User Profiles** - Manage profile information and vehicle details
✅ **Environmental Impact** - Track fuel saved and carbon footprint reduction
✅ **Cost Savings** - Share transportation costs with colleagues
✅ **Community Building** - Connect with fellow employees

## Tech Stack

### Frontend
- **React 18** - UI library
- **React Router** - Navigation
- **Axios** - HTTP client
- **CSS3** - Styling
- **React Icons** - UI icons

### Backend
- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **MongoDB** - Database
- **JWT** - Authentication
- **bcryptjs** - Password hashing

## Project Structure

```
ride-share-app/
├── frontend/
│   ├── public/
│   │   └── index.html
│   ├── src/
│   │   ├── components/
│   │   │   └── Navbar.js
│   │   ├── pages/
│   │   │   ├── Login.js
│   │   │   ├── Dashboard.js
│   │   │   ├── FindRide.js
│   │   │   ├── OfferRide.js
│   │   │   ├── RideDetails.js
│   │   │   └── Profile.js
│   │   ├── styles/
│   │   │   ├── index.css
│   │   │   ├── App.css
│   │   │   ├── Navbar.css
│   │   │   ├── Login.css
│   │   │   ├── Dashboard.css
│   │   │   ├── FindRide.css
│   │   │   ├── OfferRide.css
│   │   │   ├── RideDetails.css
│   │   │   └── Profile.css
│   │   ├── App.js
│   │   └── index.js
│   └── package.json
├── backend/
│   ├── models/
│   │   ├── User.js
│   │   └── Ride.js
│   ├── routes/
│   │   ├── auth.js
│   │   ├── rides.js
│   │   └── users.js
│   ├── middleware/
│   │   └── auth.js
│   ├── .env
│   ├── .gitignore
│   ├── server.js
│   └── package.json
└── README.md
```

## Installation

### Prerequisites
- Node.js (v14 or higher)
- MongoDB (local or Atlas)
- npm or yarn

### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file with the following variables:
```
MONGODB_URI=mongodb://localhost:27017/ride-share-db
JWT_SECRET=your-secret-key
PORT=5000
NODE_ENV=development
```

4. Start the backend server:
```bash
npm start
# or for development with auto-reload:
npm run dev
```

The backend will run on `http://localhost:5000`

### Frontend Setup

1. Navigate to the frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Start the React development server:
```bash
npm start
```

The frontend will run on `http://localhost:3000`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login user

### Rides
- `GET /api/rides/available` - Get available rides (with filters)
- `GET /api/rides/:id` - Get ride details
- `POST /api/rides/create` - Create a new ride (requires auth)
- `POST /api/rides/:id/book` - Book a ride (requires auth)
- `POST /api/rides/:id/cancel` - Cancel ride booking (requires auth)

### Users
- `GET /api/users/profile` - Get user profile (requires auth)
- `PUT /api/users/profile` - Update user profile (requires auth)

## Usage

1. **Register/Login**
   - Create a new account or log in with existing credentials
   - Add your vehicle information if you plan to offer rides

2. **Find a Ride**
   - Use the "Find Ride" page to search for available rides
   - Filter by departure, destination, and date
   - View ride details and book available seats

3. **Offer a Ride**
   - Post a ride offering on the "Offer Ride" page
   - Set departure point, destination, date, time, and cost
   - Manage your ride bookings from the dashboard

4. **Manage Profile**
   - Update your profile information
   - Track your environmental impact and cost savings
   - View ride history

## Natural Resources Conservation

Every ride shared contributes to preserving natural resources:
- **Fuel Savings** - Reduce fuel consumption by sharing vehicles
- **Carbon Footprint Reduction** - Lower emissions per person
- **Pollution Control** - Fewer vehicles on the road reducing air and noise pollution
- **Resource Preservation** - Conserve Earth's natural resources for future generations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the ISC License.

## Support

For support, email: support@ecoride.com
Or create an issue on the GitHub repository.

## Future Enhancements

- Real-time location tracking
- In-app messaging between users
- Rating and review system
- Payment integration
- Mobile app (iOS & Android)
- Ride history and analytics
- Recurring rides scheduling
- Integration with company calendars
- Environmental dashboard with detailed metrics

---

**Mana Prayanam: Save Natural Resources | Made with ❤️ for a sustainable future**
