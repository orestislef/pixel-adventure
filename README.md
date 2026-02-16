# Pixel Adventure 🎮

A retro-style 2D platformer game built with Flutter and Flame engine, inspired by Super Mario Bros.

## Features

- 🏃 Classic platformer gameplay
- 🪙 Collectible coins (+100 points)
- 👾 Enemy stomping mechanics (+200 points)
- ❤️ 3 lives system
- 📱 Touch controls for mobile
- 🎨 Custom rendered pixel-style graphics
- 🏆 Score tracking
- 🚩 Level completion goals

## Getting Started

### Prerequisites
- Flutter SDK 3.x or higher
- Android Studio / Xcode (for mobile deployment)

### Run the Game

```bash
# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Run in web browser
flutter run -d chrome

# Build APK for Android
flutter build apk --release

# Build for iOS (requires macOS)
flutter build ios --release
```

## Controls

### Mobile (Touch)
- **← / → buttons**: Move left/right
- **JUMP button**: Jump

### Desktop/Web
- Works with touch buttons in HUD

## Game Mechanics

- **Coins**: Collect for +100 points
- **Enemies**: Stomp from above for +200 points, touching from side loses a life
- **Falling**: Falling off screen loses a life
- **Flag**: Reach the flag to complete the level
- **Lives**: 3 lives per game

## Project Structure

```
lib/
├── main.dart              # App entry point
├── game/
│   ├── pixel_adventure_game.dart  # Main game class
│   ├── player/            # Player component
│   ├── platforms/         # Ground and platforms
│   ├── enemies/           # Enemy AI
│   └── items/             # Coins, flags
├── ui/                    # HUD, menus
└── utils/                 # Constants, asset paths
```

## Built With

- [Flutter](https://flutter.dev) - UI framework
- [Flame](https://flame-engine.org) - 2D game engine

## Future Enhancements

- [ ] Add sprite-based animations
- [ ] Add background music and sound effects
- [ ] Add more level designs
- [ ] Add power-ups
- [ ] Add high score persistence
