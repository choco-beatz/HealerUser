---

# Healer 

Healer is a **therapy management application** built using **Flutter**. It allows clients to browse therapists, request to be their clients, book appointments, receive reminders, and chat in real-time—all in a seamless and user-friendly interface.  

## 📖 Table of Contents  
- [Description](#description)  
- [Features](#features)  
- [Technologies Used](#technologies-used)  
- [Installation](#installation)  
- [Usage](#usage)  
- [Contributing](#contributing)  

## 📝 Description  
Healer is designed to simplify the therapy process for clients. Users can explore therapists, request to be their clients, and once approved, book appointments and chat in real-time. The app also includes appointment reminders and supports multiple therapist-client relationships.  

## ✨ Features  
- **Find Therapists:** View available therapists and request to be their client.  
- **Multiple Therapists Support:** Users can connect with multiple therapists simultaneously.  
- **Appointment Booking:** Schedule therapy sessions directly through the app.  
- **Reminders:** Get notified on the day of the appointment.  
- **Real-Time Chat:** Secure messaging with therapists using WebSockets.  
- **Secure Storage:** Uses Flutter Secure Storage for sensitive data.  
- **Online Payments:** Integrated **Razorpay** for smooth transactions.  
- **Video Calling:** Enables **Agora RTC** for online therapy sessions.  
- **Calendar Integration:** Keep track of therapy schedules using **TableCalendar**.  

## 🛠️ Technologies Used  
- **Flutter** – Cross-platform UI framework  
- **Dart** – Programming language used in Flutter  
- **State Management:** BLoC (flutter_bloc)  
- **Local Storage:** Flutter Secure Storage  
- **Networking:** HTTP package  
- **Real-Time Communication:** Agora RTC, Agora RTM, and Socket.IO  
- **Authentication & Security:** JSON Web Token (dart_jsonwebtoken)  
- **Payments:** Razorpay Flutter  
- **UI Enhancements:** Google Fonts, Cupertino Icons, Lottie Animations  

## 📦 Dependencies  
```yaml
dependencies:
  flutter_bloc: ^8.1.6
  http: ^1.2.2
  flutter_secure_storage: ^9.2.2
  dart_jsonwebtoken: ^2.14.1
  table_calendar: ^3.1.3
  intl: ^0.19.0
  razorpay_flutter: ^1.3.7
  permission_handler: ^11.3.1
  agora_rtc_engine: ^6.5.0
  socket_io_client: ^3.0.2
  flutter_markdown: ^0.7.4+3
  image_picker: ^1.1.2
  http_parser: ^4.0.2
  lottie: ^3.1.3
  agora_rtm: ^1.5.9
  flutter_launcher_icons: ^0.14.3
  firebase_core: ^3.4.0
```

## 🚀 Installation  
1. **Clone the Repository:**  
   ```sh
   git clone https://github.com/yourusername/healer.git
   cd healer
   ```  
2. **Install Dependencies:**  
   ```sh
   flutter pub get
   ```  
3. **Run the Application:**  
   ```sh
   flutter run
   ```  

## 📌 Usage  
- Browse and request therapists to be your client.  
- Once accepted, view their available schedule.  
- Book therapy appointments through the in-app calendar.  
- Receive appointment reminders.  
- Chat with therapists in real-time.  
- Make secure online payments for sessions.  

## 🤝 Contributing  
Contributions are welcome! If you'd like to improve **Healer**, feel free to submit a pull request or open an issue.  
