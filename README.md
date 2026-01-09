# NoteMe

**NoteMe** is an iOS application for creating smart notes and reminders with time-based and location-based notifications.  
The app supports user authentication, cloud backup, and place search using Apple Maps and Foursquare, while remaining fully functional offline.

---

## **Features**
- Create and manage notes and reminders  
- Time-based and location-based notifications  
- Location selection using **Apple Maps**  
- Nearby places and location search via **Foursquare API**  
- User registration and login with **Firebase Authentication**  
- Local data storage using **CoreData**  
- Cloud backup and restore via **Firebase Storage**  
- Offline-first architecture with automatic sync  
- Clean and native **UIKit** interface  

---

## **Requirements**
- iOS 15.0+  
- Xcode 14+  
- Swift 5.7+  

---

## **📦 Technologies**
- **Swift / UIKit**  
- **CoreData** — local persistence for notes and notifications  
- **Firebase Authentication** — user registration and login  
- **Firebase Storage** — backup and restore of user data  
- **MapKit (Apple Maps)** — map display and location selection  
- **Foursquare API** — nearby places and location search  
- **UserNotifications** — local notification handling  
- **SnapKit** — UI layout (if used)  
- **URLSession** — networking  

---

## **Architecture**
- **MVVM** — clear separation of UI, business logic, and data  
- **Coordinator** — navigation and app flow management  
- **Service Layer** — Firebase, notifications, and networking  
- **Data Workers** — CoreData and backup handling  

---

## **Notifications System**
- **NotificationService**  
  - Scheduling, updating, and removing notifications  
  - Supports time-based and region-based triggers  

- **NotificationDataWorker**  
  - Saves notifications to **CoreData**  
  - Handles backup and restore via **Firebase Storage**  

Notifications are stored locally and automatically synced to the cloud.

---

## **Locations & Places**
- Location selection using **Apple Maps**  
- Place discovery with **Foursquare API**:
  - **Nearby** places around the user  
  - **Search** by name or keyword  
- Attach specific locations to reminders  

---

## **Authentication**
- User registration and login via **Firebase Authentication**  
- Email / Password support  
- Architecture prepared for future providers (Apple / Google Sign-In)

---

## **Backup & Sync**
- Notes and notifications are:
  - Stored locally in **CoreData**  
  - Backed up to **Firebase Storage**  
- Data is restored automatically after login or app reinstall  

---

## **Testing**
- Unit tests are implemented in **NoteMeTests**  
- Tests cover:
  - Notification scheduling logic  
  - CoreData persistence  
  - Backup and restore workflows  
  - Business logic validation in ViewModels  
- Designed to ensure reliability and regression safety  

---

## **Permissions**
- **Location When In Use** (`NSLocationWhenInUseUsageDescription`)  
  *Required for location-based reminders*  

- **Notifications**  
  *Required to deliver reminders to the user*  

---

## **Installation**
1. Clone the repository  
   ```bash
   git clone https://github.com/yourusername/NoteMe.git
