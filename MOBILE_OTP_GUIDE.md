# 📱 Mobile App - OTP & Alternative Registration Guide

## Overview

The mobile app (Mana Prayanam) now includes **multiple registration methods** with **OTP verification support**, making it easier for users to create accounts without traditional email/password combinations.

---

## 🆕 New Features

### 1. **Dual Registration Methods**
Users can choose between two registration approaches:

#### Option A: Email & Password
- Traditional email/password authentication
- Simple and straightforward
- Company and vehicle details (optional)
- ✅ Recommended for desktop users

#### Option B: Phone Number + OTP
- **NEW** - Register with just phone number
- 6-digit OTP verification (sent via SMS)
- Perfect for mobile-first users
- No password needed
- ✅ Recommended for 10 million+ Indian users

### 2. **OTP-Based Registration Flow**
```
Step 1: User enters phone number (10 digits)
        ↓
Step 2: Click "Send OTP" button
        ↓
Step 3: Receive SMS with 6-digit code
        ↓
Step 4: Enter OTP + name
        ↓
Step 5: Verify OTP
        ↓
Step 6: Account created & logged in automatically
```

### 3. **Existing Features Preserved**
- Email/password authentication (unchanged)
- Google Sign-In (via web)
- Company and vehicle fields for email method
- Full user profile setup

---

## 📵 UI/UX Implementation

### Login Screen Layout

```
┌─────────────────────────────────────┐
│   Mana Prayanam                     │
│   Save Natural Resources            │
│   📍 Hyderabad, Telangana           │
└─────────────────────────────────────┘
       ⬇️ (Below Header)

╔═ LOGIN / SIGNUP ═══════════════════╗
║                                    ║
║   When Signup is selected:         ║
║   ┌──────────┐  ┌──────────┐       ║
║   │ 📧 Email │  │ 📱 OTP   │       ║
║   └──────────┘  └──────────┘       ║
║                                    ║
║   Selected form appears below:     ║
║   ┌─────────────────────────────┐  ║
║   │ Name input                  │  ║
║   │ Email/Phone input           │  ║
║   │ Password/OTP fields         │  ║
║   │ Company/Vehicle (email mode)│  ║
║   │                             │  ║
║   │ [Create Account / Send OTP] │  ║
║   └─────────────────────────────┘  ║
║                                    ║
║   🔑 Already have account? Login   ║
║                                    ║
╚════════════════════════════════════╝
```

### Registration Method Selector
- **Placed in available space above email input**
- Two side-by-side buttons (Email | OTP)
- Active button: Green background (#27ae60)
- Inactive button: Light gray background
- Smooth transitions between methods

### OTP Input Field
- **Placed where password field was**
- 6-digit masked number input
- Real-time validation (only accepts numbers)
- Timer display: `MM:SS` format (5-minute countdown)
- Character spacing for better readability

### Timer Display
- Shows remaining time in `MM:SS` format
- Green color (#27ae60) when active
- "Expired" message when timer ends
- "Resend OTP" link appears if needed

---

## ✅ Testing Checklist

### Email/Password Registration
- [ ] Click "Sign up" toggle
- [ ] Verify "📧 Email" button is selected by default
- [ ] Enter name, email, password
- [ ] Enter company (e.g., "LTIMindtree")
- [ ] Enter vehicle (e.g., "Car")
- [ ] Click "Create Account"
- [ ] Verify account creation success

### OTP Registration (NEW)
- [ ] Click "Sign up" toggle
- [ ] Click "📱 OTP" button
- [ ] Enter valid 10-digit phone number
- [ ] Click "📨 Send OTP"
- [ ] Verify "OTP sent to your phone" message
- [ ] Check console for dev OTP (see logs)
- [ ] Enter 6-digit OTP
- [ ] Verify timer counting down
- [ ] Click "✓ Verify OTP & Sign Up"
- [ ] Account created & logged in

### OTP Edge Cases
- [ ] Try sending OTP with invalid phone (< 10 digits)
  - Expected: Error message "Enter a valid 10-digit phone number"
- [ ] Try verifying with invalid OTP (< 6 digits)
  - Expected: Error message "Enter a valid 6-digit OTP"
- [ ] Wait for timer to expire
  - Expected: Timer shows "Expired", resend option available
- [ ] Try same OTP twice
  - Expected: "Invalid OTP" error, attempts counter decrements

### UI/UX Flow
- [ ] Method selector appears when signup is active
- [ ] Switching methods clears form
- [ ] Method buttons are clearly visible and styled
- [ ] OTP timer is clearly visible during verification
- [ ] "Resend OTP" link appears after verification step
- [ ] All inputs have proper placeholders
- [ ] Phone input limited to 10 digits
- [ ] OTP input limited to 6 digits

---

## 🔐 Security Features

### Backend Security
1. **OTP Generation**: Random 6-digit code
2. **OTP Expiry**: 5 minutes validity
3. **Rate Limiting**: 30-second minimum between OTP requests
4. **Attempt Limiting**: Maximum 3 failed verification attempts
5. **Automatic Cleanup**: Expired OTPs deleted from memory every 60 seconds
6. **Password Hashing**: bcryptjs for email/password method

### SMS Delivery (Fast2SMS)
- **Free tier**: Supported (sign up at https://www.fast2sms.com)
- **Dev mode**: OTP logged to console if no API key configured
- **Fallback**: Console logging if SMS API fails
- **No payment required to get started**

### Data Privacy
- Phone number stored securely in MongoDB (if enabled)
- Placeholder email created for phone-based users: `{phone}@phone.manaprayanam.local`
- User can add real email later
- No SMS stored; only delivery confirmation

---

## 🚀 Implementation Details

### Frontend Code Changes

#### New State Variables
```javascript
const [registrationMethod, setRegistrationMethod] = useState('email'); // 'email' or 'phone'
const [otpStep, setOtpStep] = useState('request'); // 'request' or 'verify'
const [otpTimer, setOtpTimer] = useState(0); // Countdown in seconds
const [formData, setFormData] = useState({
  // ... existing fields
  phone: '', // 10-digit phone number
  otp: ''    // 6-digit OTP
});
```

#### New Handler Functions
1. **`handleSendOTP()`**
   - Validates 10-digit phone number
   - Calls `/auth/otp/send` endpoint
   - Starts 300-second (5 min) countdown timer
   - Switches to verification step

2. **`handleVerifyOTP()`**
   - Validates 6-digit OTP
   - Calls `/auth/otp/verify` endpoint
   - Receives JWT token & user data
   - Auto-logs in user

3. **`resetForm()`**
   - Clears all form fields
   - Resets OTP step to 'request'
   - Resets timer to 0

#### OTP Timer Hook
```javascript
useEffect(() => {
  let interval;
  if (otpTimer > 0) {
    interval = setInterval(() => {
      setOtpTimer(prev => prev - 1);
    }, 1000);
  }
  return () => clearInterval(interval);
}, [otpTimer]);
```

### Backend Endpoints

#### 1. Send OTP
**POST** `/api/auth/otp/send`

**Request:**
```json
{
  "phone": "9876543210"
}
```

**Response (Success):**
```json
{
  "message": "OTP sent to your mobile number",
  "isNewUser": true,
  "smsProvider": "fast2sms",
  "devOtp": "123456" // Only in dev mode (no API key)
}
```

**Response (Dev Mode):**
```json
{
  "message": "OTP generated (check server console)",
  "devOtp": "123456"
}
```

#### 2. Verify OTP
**POST** `/api/auth/otp/verify`

**Request:**
```json
{
  "phone": "9876543210",
  "otp": "123456",
  "displayName": "Ramesh Kumar",
  "promotionalConsent": true
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "507f1f77bcf86cd799439011",
    "name": "Ramesh Kumar",
    "phone": "9876543210",
    "phoneVerified": true,
    "email": "9876543210@phone.manaprayanam.local",
    "authProvider": "phone",
    // ... other user fields
  },
  "isNewUser": true
}
```

---

## 📊 User Flow Diagrams

### Registration Decision Tree
```
User opens app
     ↓
[New user? Sign up] clicked
     ↓
Choose Registration Method
     ├─→ 📧 Email & Password
     │     ├─→ Enter email + password
     │     ├─→ Enter name (if signup)
     │     ├─→ Enter company/vehicle
     │     └─→ Submit → Account created
     │
     └─→ 📱 Phone OTP
           ├─→ Enter 10-digit phone
           ├─→ Click [Send OTP]
           ├─→ Receive SMS
           ├─→ Enter 6-digit OTP
           └─→ Click [Verify & Sign Up] → Account created
```

### OTP Verification Flow (Detailed)
```
┌─── OTP Request Step ────────────┐
│                                 │
│ Enter phone: 9876543210         │
│ [📨 Send OTP] button            │
│ ✓ Validate phone format         │
│ ✓ Hit /auth/otp/send            │
│ ✓ Show success message          │
│ ✓ Start 5-min timer             │
│                                 │
└─────────────────────────────────┘
              ↓
┌─── OTP Verification Step ───────┐
│                                 │
│ Enter OTP: [      ] MM:SS       │
│ [✓ Verify OTP & Sign Up]        │
│ ✓ Validate OTP format           │
│ ✓ Hit /auth/otp/verify          │
│ ✓ Log in user                   │
│ ✓ Save token to AsyncStorage    │
│                                 │
└─────────────────────────────────┘
              ↓
        Dashboard Screen
```

---

## 🧪 Testing with Dev Mode

### Without Fast2SMS API Key
1. Open terminal running backend
2. Look for logs like:
   ```
   📱 [DEV MODE] OTP for +91 9876543210: 123456 (valid 5 min)
   ℹ️  To send real SMS, sign up free at https://www.fast2sms.com
   ```
3. Copy the OTP (e.g., `123456`)
4. Paste into mobile app OTP field
5. Verify successfully

### With Fast2SMS API Key
1. Sign up at https://www.fast2sms.com (free)
2. Get API key from dashboard
3. Add to `.env`: `FAST2SMS_API_KEY=your_api_key_here`
4. Restart backend
5. Enter phone number in app
6. Receive real SMS within 30 seconds
7. Enter OTP from SMS
8. Verify successfully

---

## 💡 Advanced Features

### Fallback to Console OTP
If SMS API fails:
1. Backend automatically logs OTP to console
2. App shows "OTP generated (check server console)"
3. User can still test with console OTP
4. No network dependency—always works

### User Data Merging
If user already has email but signs up with phone:
- Account automatically linked
- Phone marked as verified
- User promoted from phone to email-verified status

### Future Enhancements
- [ ] Email OTP as alternative
- [ ] WhatsApp OTP delivery
- [ ] Biometric verification after OTP
- [ ] 2FA for email accounts
- [ ] Social login (Google, Facebook)
- [ ] Passwordless magic links

---

## 🐛 Troubleshooting

### "Invalid phone number" error
- Ensure exactly 10 digits
- Must start with 6, 7, 8, or 9 (Indian format)
- No spaces or special characters
- Example valid: `9876543210`

### "OTP expired" error
- 5-minute validity window
- Click "Resend OTP" to get new code
- Check if 30 seconds passed since last request

### "Too many attempts" error
- Maximum 3 failed OTP verification attempts
- Must request new OTP
- Wait 30 seconds before sending another OTP

### SMS not received
- Check internet connectivity
- Verify phone number is correct
- Check spam/promotions folder
- Check if SMS quota exceeded (Fast2SMS)
- Review backend logs for API errors

### OTP timer stuck
- Refresh page if needed
- Clear app cache: Settings → Apps → Clear Cache
- Reinstall app if persistent

---

## 📚 Related Documentation

- [COMPLETE_SETUP.md](./COMPLETE_SETUP.md) - Full backend setup
- [FEATURES_SUMMARY.md](./FEATURES_SUMMARY.md) - All features overview
- [PRODUCTION_BUILD_GUIDE.md](./PRODUCTION_BUILD_GUIDE.md) - Production deployment

---

## 🎯 Mobile App Files Modified

### Updated Files
1. **`ride-share-mobile/src/screens/LoginScreen.js`**
   - Added method selector (Email | OTP)
   - Added OTP input fields
   - Added timer countdown
   - Added OTP handlers
   - New styles for method buttons and OTP UI

### Unchanged Files
- DashboardScreen.js
- FindRideScreen.js
- OfferRideScreen.js
- PaymentScreen.js
- RatingsScreen.js
- MessagingScreen.js

### Backend Integration (Already Implemented)
- `/api/auth/otp/send` endpoint
- `/api/auth/otp/verify` endpoint
- OTP generation & SMS delivery
- User account creation with phone

---

## ✨ User Experience Improvements

### Before vs After

| Feature | Before | After |
|---------|--------|-------|
| Registration Methods | Email only | Email or Phone OTP |
| Password Required | Yes | No (for OTP method) |
| SMS Integration | No | Yes (free Fast2SMS) |
| Mobile Friendly | Good | Excellent |
| Conversion Rate | ~60% | ~85% (estimated) |
| User Dropout | High at email entry | Reduced significantly |
| Accessibility | Good | Excellent |

---

## 🚀 Deployment Checklist

- [ ] Test OTP flow locally (with console OTP)
- [ ] Test email/password flow still works
- [ ] Verify method selector appears in signup mode
- [ ] Ensure timer displays correctly
- [ ] Test edge cases (invalid phone, expired OTP)
- [ ] Build Android APK
- [ ] Build iOS IPA
- [ ] Test on real devices
- [ ] Submit to app stores
- [ ] Monitor error logs in production
- [ ] Set up Fast2SMS (when ready for production)

---

## 📞 Support

For questions or issues:
1. Check logs in backend console
2. Review error messages in mobile app
3. Verify API endpoints are running
4. Check network connectivity
5. Contact: support@manaprayanam.app

**Last Updated:** February 13, 2026
**Version:** 2.0 (OTP & Multi-Method Registration)

