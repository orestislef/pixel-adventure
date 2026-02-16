# Pixel Adventure - 2D Platformer Game

A retro-style 2D platformer game built with Flutter and Flame engine, inspired by Super Mario Bros.

## Game Overview

- **Theme**: Classic Grass/Forest platformer
- **Hero**: Mario-like plumber/hero character
- **Style**: 16-bit pixel art
- **Target**: Android & iOS

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Flutter 3.x |
| Game Engine | Flame (v1.18+) |
| Physics | Forge2D (via Flame) |
| Audio | flame_audio |
| Level Design | Tiled (flame_tiled) |
| State Management | Riverpod |
| Persistence | shared_preferences |

## Project Structure

```
platformer/
├── lib/
│   ├── main.dart
│   ├── game/
│   │   ├── pixel_adventure_game.dart    # Main game class
│   │   ├── player/
│   │   │   ├── player.dart              # Player component
│   │   │   └── player_state.dart        # State machine
│   │   ├── enemies/
│   │   │   ├── enemy.dart               # Base enemy class
│   │   │   ├── walking_enemy.dart       # Goomba-style enemy
│   │   │   └── jumping_enemy.dart       # Bouncing enemy
│   │   ├── platforms/
│   │   │   ├── platform.dart            # Platform base
│   │   │   └── ground.dart              # Solid ground
│   │   ├── items/
│   │   │   ├── coin.dart                # Collectible coins
│   │   │   └── power_up.dart            # Power-ups
│   │   └── effects/
│   │       ├── dust_particle.dart       # Landing dust
│   │       └── sparkle_particle.dart    # Coin sparkle
│   ├── levels/
│   │   ├── level.dart                   # Level manager
│   │   └── level_world.dart             # Forge2D world
│   ├── ui/
│   │   ├── hud.dart                     # In-game HUD
│   │   ├── main_menu.dart               # Main menu screen
│   │   ├── pause_menu.dart              # Pause overlay
│   │   └── game_over.dart               # Game over screen
│   ├── input/
│   │   └── touch_controls.dart          # Mobile controls
│   ├── managers/
│   │   ├── game_manager.dart            # Game state
│   │   ├── audio_manager.dart           # Audio controller
│   │   └── level_manager.dart           # Level progression
│   └── utils/
│       ├── assets.dart                  # Asset paths
│       └── constants.dart               # Game constants
├── assets/
│   ├── images/
│   │   ├── player/                      # Player sprites
│   │   ├── enemies/                     # Enemy sprites
│   │   ├── tiles/                       # Tile textures
│   │   ├── backgrounds/                 # Parallax BGs
│   │   ├── items/                       # Coins, power-ups
│   │   └── ui/                          # UI elements
│   ├── audio/
│   │   ├── sfx/                         # Sound effects
│   │   └── music/                       # Background music
│   ├── tiles/                           # Tiled level files
│   └── fonts/                           # Custom fonts
└── pubspec.yaml
```

## Core Features

### Gameplay
- [x] Player movement (left/right run)
- [x] Variable jump height (tap vs hold)
- [x] Gravity and physics
- [x] Platform collision detection
- [x] Stomping enemies
- [x] Collecting coins
- [x] Score system
- [x] Lives system (3 lives)
- [x] Multiple levels
- [x] End-level flag

### Visual Polish
- [x] Parallax scrolling backgrounds (4 layers)
- [x] Character animation (idle, run, jump, death)
- [x] Particle effects (dust, sparkles)
- [x] Screen shake on hit
- [x] Smooth camera following
- [x] UI animations

### Audio
- [x] Background music (8-bit chiptune)
- [x] Jump sound
- [x] Coin collect sound
- [x] Enemy stomp sound
- [x] Death sound
- [x] Level complete jingle

### Controls
- [x] Virtual joystick (mobile)
- [x] Touch buttons (left, right, jump)
- [x] Keyboard support (testing)

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flame: ^1.18.0
  flame_forge2d: ^0.18.0
  flame_audio: ^2.10.0
  flame_tiled: ^1.21.0
  shared_preferences: ^2.2.0
  flutter_riverpod: ^2.5.0
```

## Free Asset Sources

| Asset Type | Source | URL |
|------------|--------|-----|
| Sprites | Kenney.nl | https://kenney.nl/assets/platformer-pack-redux |
| Characters | itch.io | https://itch.io/game-assets/free/tag-pixel-art |
| Backgrounds | Craftpix | https://craftpix.net/freebies/ |
| Tiles | OpenGameArt | https://opengameart.org/ |
| Music | OpenGameArt | https://opengameart.org/art-search?keys=chiptune |
| SFX | Freesound | https://freesound.org/ |

## Implementation Phases

### Phase 1: Setup ✅
- [x] Create Flutter project
- [x] Add dependencies
- [x] Setup folder structure
- [ ] Download assets

### Phase 2: Core Engine
- [ ] Main game class (FlameGame)
- [ ] World/camera setup
- [ ] Basic game loop
- [ ] Physics world (Forge2D)

### Phase 3: Player
- [ ] Sprite loading + animation
- [ ] Movement component
- [ ] Jump physics
- [ ] Collision body

### Phase 4: World
- [ ] Platform components
- [ ] Collision detection
- [ ] Parallax background
- [ ] Camera following

### Phase 5: Enemies
- [ ] Walking enemy AI
- [ ] Collision with player
- [ ] Stomp mechanics
- [ ] Death animation

### Phase 6: Collectibles
- [ ] Coin spawning
- [ ] Collision detection
- [ ] Score system
- [ ] UI updates

### Phase 7: Game Systems
- [ ] Lives system
- [ ] Level progression
- [ ] Game states
- [ ] High score saving

### Phase 8: UI/Menus
- [ ] Main menu
- [ ] In-game HUD
- [ ] Pause overlay
- [ ] Game over/win screens

### Phase 9: Audio
- [ ] Load audio files
- [ ] BGM implementation
- [ ] SFX triggers
- [ ] Volume settings

### Phase 10: Polish
- [ ] Particle effects
- [ ] Screen shake
- [ ] Transitions
- [ ] Testing & optimization

## Game Constants

```dart
// Physics
static const double gravity = 9.8;
static const double playerSpeed = 150.0;
static const double jumpForce = 400.0;
static const double maxJumpTime = 0.4;

// World
static const double tileSize = 32.0;
static const double pixelsPerMeter = 32.0;

// Player
static const int maxLives = 3;
static const double playerWidth = 32.0;
static const double playerHeight = 48.0;

// Enemies
static const double enemySpeed = 50.0;
static const double enemySize = 32.0;
```

## Running the Game

```bash
# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Build APK (Android)
flutter build apk --release

# Build iOS (requires macOS)
flutter build ios --release
```

## Credits

- Built with [Flutter](https://flutter.dev) and [Flame](https://flame-engine.org)
- Assets from Kenney.nl, Craftpix.net, OpenGameArt.org
