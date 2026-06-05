# TDMU Notes - Flutter Note-Taking App

A beautiful and feature-rich note-taking application built with Flutter. Organize your notes with colors, tags, and pinning functionality.

## ✨ Features

- 📝 **Create & Edit Notes** - Write and edit notes with ease
- 🎨 **Color Customization** - Assign different colors to your notes for better organization
- 📌 **Pin Important Notes** - Pin your most important notes to keep them accessible
- 🏷️ **Tags Support** - Organize notes with tags (default: 'Chung')
- 💾 **Local Storage** - Secure local storage using SQLite database
- 🌓 **Dark/Light Theme** - Automatic theme based on system settings
- 📱 **Cross-Platform** - Works on Android, iOS, Linux, macOS, and Windows
- 🎯 **Staggered Grid View** - Beautiful staggered layout for notes display

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.10.4 or higher
- Dart 3.10.4 or higher
- Android SDK (for Android development)
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/tdmu-notes.git
   cd th5
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for different platforms

**Android:**
```bash
flutter build apk
# or for release
flutter build appbundle
```

**iOS:**
```bash
flutter build ios
```

**Web:**
```bash
flutter build web
```

**Windows:**
```bash
flutter build windows
```

**Linux:**
```bash
flutter build linux
```

**macOS:**
```bash
flutter build macos
```

## 📁 Project Structure

```
th5/
├── lib/
│   ├── main.dart                 # Entry point of the app
│   ├── models/
│   │   └── note.dart            # Note data model
│   ├── screens/
│   │   ├── home_screen.dart      # Main home screen
│   │   └── edit_note_screen.dart # Note editing screen
│   └── services/
│       └── database_helper.dart  # SQLite database operations
├── android/                      # Android native code
├── ios/                          # iOS native code
├── web/                          # Web support files
├── windows/                      # Windows native code
├── linux/                        # Linux native code
├── macos/                        # macOS native code
├── pubspec.yaml                  # Flutter dependencies
└── analysis_options.yaml         # Lint rules
```

## 📦 Dependencies

- **flutter** - Flutter framework
- **cupertino_icons** - iOS-style icons
- **sqflite** ^2.3.0 - SQLite database
- **path** ^1.9.0 - File path utilities
- **intl** ^0.19.0 - Internationalization
- **flutter_staggered_grid_view** ^0.7.0 - Staggered grid layout
- **google_fonts** ^6.2.1 - Google Fonts support

## 🎯 Key Features Explained

### Note Model
```dart
class Note {
  int? id;
  String title;
  String content;
  String createdAt;
  int isPinned;        // 0: false, 1: true
  int colorValue;      // Color code for the note
  String tag;          // Tag for organizing notes
}
```

### Database Operations
- Create, Read, Update, Delete (CRUD) operations using SQLite
- Local persistence for offline access
- Efficient data management through DatabaseHelper service

### User Interface
- **Material Design** - Following Material Design guidelines
- **Responsive Layout** - Adapts to different screen sizes
- **Staggered Grid** - Beautiful card-based note display
- **Theme Support** - Light and dark modes based on system settings

## 🔧 Configuration

### Styling
- Font: Times New Roman (customizable)
- Primary Color: Blue
- Supports both light and dark themes

### Database
- Local SQLite database stored on device
- No cloud sync (local-first approach)
- Automatic database initialization

## 📝 Usage

1. **Create a Note**
   - Tap the "+" button on the home screen
   - Enter title and content
   - Select color (optional)
   - Add tag (optional)
   - Save the note

2. **Edit a Note**
   - Tap on any note to open it
   - Modify the content
   - Save changes

3. **Pin a Note**
   - Long press on a note to see options
   - Select "Pin" to keep it on top

4. **Delete a Note**
   - Swipe or use the delete option from note menu

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Lê Nhật Nhân**
- Student ID: 2224802010860
- Contact: lenhatnhan999@gmail.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The open-source community for the great packages used in this project


## 🎓 Educational Purpose

This project was created as part of coursework at TDMU (Thủ Dầu Một University).

---

**Made with ❤️ using Flutter**
