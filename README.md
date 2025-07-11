# 🧚‍♀️ Fairy Tales App

A magical Flutter application for creating, editing, narrating, and playing interactive fairy tales with AI-powered content generation, voice synthesis, animations, and cloud synchronization.

## ✨ Features

### 📚 Story Library
- Grid-based story browser with beautiful cover art
- Search, sort, and filter stories by tags, age groups, and authors
- Favorites system with cloud synchronization
- Story progress tracking and reading history

### 🎮 Interactive Story Player
- Scene-based storytelling with branching narratives
- AI-powered voice narration with multiple voice options
- Beautiful background images and animations
- Ambient audio and music integration
- Left-side text toggle (show/hide during narration)
- Right-side choice buttons for story progression
- Secret touch zones for hidden story paths
- Multiple endings system

### ✍️ Story Editor
- Intuitive scene-based story creation
- Rich text editor with formatting options
- Media upload (images, audio, animations)
- AI-powered content generation
- Scene linking with conditional logic
- Autosave and version history
- Template system for quick story creation

### 🧠 AI Integration
- **Text Generation**: GPT, DeepSeek, Mistral, Phi-3 support
- **Voice Synthesis**: Coqui TTS, ElevenLabs, Silero integration
- **Image Generation**: Stable Diffusion, Kandinsky support
- **Audio Generation**: MusicGen, AudioLDM, Bark for effects
- **Animation Support**: Lottie and AnimateDiff integration

### 🌟 Gameplay Features
- Multiple story endings and branching paths
- AI-driven companion characters
- Secret areas and easter eggs
- Mini-games and puzzles integration
- Achievement system
- Memory gallery for completed stories
- Interactive character chat

### 🎨 User Experience
- Age-appropriate interface modes (child/advanced/accessibility)
- Customizable themes, fonts, and button styles
- Fantasy-themed UI with magical animations
- Onboarding helper character
- Smart story recommendations
- Parental controls and content filtering

### 🌍 Cloud Features
- Firebase/Supabase authentication
- Cross-device story synchronization
- Online story library and sharing
- Multi-profile support (child/parent/teacher)
- Story export as animated videos
- Community features and story sharing

## 🏗️ Architecture

### Tech Stack
- **Frontend**: Flutter 3.13+ with Dart
- **State Management**: Riverpod with code generation
- **Navigation**: GoRouter for type-safe routing
- **Local Storage**: Hive + SQLite for offline support
- **Cloud Backend**: Firebase/Supabase ready
- **Audio**: just_audio for multimedia playback
- **Animations**: Lottie, Rive, and flutter_animate
- **AI Integration**: Modular AI service architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── src/
│   ├── app.dart             # Main app widget
│   ├── core/                # Core functionality
│   │   ├── models/          # Data models (Story, Scene, User)
│   │   ├── services/        # Business logic services
│   │   ├── providers/       # Riverpod state management
│   │   ├── routing/         # Navigation and routing
│   │   └── theme/           # App theming system
│   └── features/            # Feature-based modules
│       ├── onboarding/      # App introduction
│       ├── auth/            # Authentication
│       ├── home/            # Main dashboard
│       ├── library/         # Story library
│       ├── story_player/    # Story playback
│       ├── story_editor/    # Story creation/editing
│       ├── ai/              # AI generation tools
│       ├── community/       # Social features
│       ├── achievements/    # Gamification
│       └── settings/        # App configuration
```

## 🚀 Getting Started

### Prerequisites
- Flutter 3.13.0 or higher
- Dart 3.1.0 or higher
- Firebase project (optional, for cloud features)
- AI service API keys (optional, for AI features)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd fairy-tales-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Setup Firebase (Optional)**
   - Create a Firebase project
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Configure Firebase Authentication and Firestore

5. **Configure AI Services (Optional)**
   - Add API keys to your environment configuration
   - Update AI service configurations in the settings

6. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

1. **Code Generation**
   ```bash
   # Run code generation for models and providers
   flutter packages pub run build_runner build --delete-conflicting-outputs
   
   # Watch for changes during development
   flutter packages pub run build_runner watch
   ```

2. **Assets**
   - Add custom fonts to `assets/fonts/`
   - Add images to `assets/images/`
   - Add animations to `assets/animations/`
   - Add audio files to `assets/audio/`

## 🎨 Customization

### Themes
The app supports extensive theming customization:
- **Color Schemes**: 6 built-in presets plus custom colors
- **Button Styles**: Rounded, square, circular, outlined
- **Age-Appropriate Themes**: Automatic color adjustment based on target age group
- **Interface Modes**: Child, advanced, and accessibility modes

### AI Integration
Configure AI services in the app settings:
- **Text Generation**: Configure GPT, Claude, or local models
- **Voice Synthesis**: Set up TTS providers and voice options
- **Image Generation**: Connect to Stable Diffusion or other services
- **Audio Generation**: Configure music and sound effect generation

## 📱 Platform Support

- ✅ Android 5.0+ (API 21+)
- ✅ iOS 12.0+
- 🚧 Web (in development)
- 🚧 Desktop (planned)

## 🤝 Contributing

We welcome contributions! Please see our contributing guidelines for more information.

### Development Workflow
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Run `flutter analyze` and `flutter test`
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for excellent state management
- Firebase for backend services
- All AI service providers for making content generation accessible
- The open-source community for inspiration and support

## 📞 Support

For support, please:
- Check the [Issues](../../issues) page for known problems
- Create a new issue for bug reports or feature requests
- Join our community discussions

---

**Made with ❤️ and ✨ magic for storytellers of all ages**