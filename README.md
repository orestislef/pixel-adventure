# Pixel Adventure

A retro-style 2D platformer game built with Flutter and Flame engine, inspired by Super Mario Bros.

## Features

- Classic platformer gameplay with physics-based movement
- Collectible coins (+100 points)
- Enemy stomping mechanics (+200 points)
- 3 lives system
- Touch controls for mobile
- Keyboard controls for desktop/web (Arrow keys, WASD, Space)
- Mario-style scrolling camera with level bounds
- Custom rendered pixel-style graphics (no sprite assets needed)
- Score tracking
- Level completion goals
- Platforms, stairs, and gaps

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

# Run on Windows desktop
flutter run -d windows

# Run in web browser
flutter run -d chrome

# Build APK for Android
flutter build apk --release

# Build for iOS (requires macOS)
flutter build ios --release
```

## Controls

### Mobile (Touch)
- **Left / Right buttons**: Move left/right
- **JUMP button**: Tap for short hop, hold for higher jump

### Desktop/Web (Keyboard)
- **Arrow Left / A**: Move left
- **Arrow Right / D**: Move right
- **Space / Arrow Up / W**: Jump (hold for higher jump)

## Game Mechanics

- **Coins**: Collect for +100 points
- **Enemies**: Stomp from above for +200 points, touching from the side loses a life
- **Platforms**: Jump onto floating platforms and stairs
- **Falling**: Walking off platform edges or falling off screen loses a life
- **Flag**: Reach the flag to complete the level
- **Lives**: 3 lives per game

## Project Structure

```
lib/
├── main.dart                        # App entry point
├── game/
│   ├── pixel_adventure_game.dart    # Main game class, level generation, camera
│   ├── player/
│   │   └── player.dart              # Player physics, controls, collision
│   ├── platforms/
│   │   ├── ground.dart              # Ground surface
│   │   └── platform.dart            # Floating platforms
│   ├── enemies/
│   │   └── walking_enemy.dart       # Patrol AI, stomp detection
│   └── items/
│       ├── coin.dart                # Collectible coins
│       └── flag.dart                # Level completion flag
├── ui/
│   ├── hud.dart                     # In-game HUD and touch controls
│   ├── main_menu.dart               # Title screen
│   ├── pause_menu.dart              # Pause overlay
│   ├── game_over.dart               # Game over screen
│   └── level_complete.dart          # Level complete screen
└── utils/
    └── constants.dart               # Game constants and enums
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
