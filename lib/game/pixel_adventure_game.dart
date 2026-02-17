import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/high_score_service.dart';
import 'levels/level_data.dart';
import 'player/player.dart';
import 'platforms/ground.dart';
import 'platforms/platform.dart';
import 'enemies/walking_enemy.dart';
import 'items/coin.dart';
import 'items/flag.dart';
import 'items/power_up.dart';

class PixelAdventureGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  late Player player;

  late double levelWidth;
  late double levelHeight;
  late double tileSize;

  GameState gameState = GameState.menu;
  int score = 0;
  int coins = 0;
  int lives = GameConstants.maxLives;
  int currentLevel = 1;
  int highScore = 0;

  bool get isPlaying => gameState == GameState.playing;

  // Power-up notification
  String? activeNotification;
  double _notificationTimer = 0;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    highScore = await HighScoreService.getHighScore();

    _calculateDimensions();
    _updateLevelWidth(LevelData.getLevel(currentLevel).widthMultiplier);

    camera.viewfinder.anchor = Anchor.center;

    _createBackground();
    _createLevel();

    overlays.add(OverlayId.hud.name);
  }

  void _calculateDimensions() {
    final screenHeight = size.y;
    levelHeight = screenHeight * 0.92;
    tileSize = levelHeight / 12;
  }

  void _updateLevelWidth(double widthMultiplier) {
    final screenWidth = size.x;
    levelWidth = screenWidth * widthMultiplier;
  }

  void showNotification(String message, {double duration = 2.5}) {
    activeNotification = message;
    _notificationTimer = duration;
  }

  void _createBackground() {
    // Extend background well beyond camera bounds to prevent black edges
    final padding = size.x;
    final bg = RectangleComponent(
      position: Vector2(-padding, -padding),
      size: Vector2(levelWidth + padding * 2, levelHeight + padding * 2),
      paint: Paint()..color = const Color(0xFF87CEEB),
    );
    world.add(bg);

    for (int layer = 0; layer < 3; layer++) {
      final mountainCount = (levelWidth / (400 - layer * 100)).floor() + 2;
      for (int i = 0; i < mountainCount; i++) {
        world.add(Mountain(
          position: Vector2(i * (400.0 - layer * 100), levelHeight - tileSize),
          height: tileSize * (3 + layer * 1.5),
          width: tileSize * (8 + layer * 2),
          color: Color.lerp(const Color(0xFF4CAF50), const Color(0xFF81C784), layer * 0.3)!,
        ));
      }
    }

    final cloudCount = (levelWidth / 200).floor();
    for (int i = 0; i < cloudCount; i++) {
      final cloud = Cloud(
        position: Vector2(i * 200.0 + (i % 3) * 50, tileSize * 0.3 + (i % 4) * tileSize * 0.4),
      );
      world.add(cloud);
    }

    for (int i = 0; i < (levelWidth / 150).floor(); i++) {
      world.add(Bush(
        position: Vector2(i * 150.0 + 50, levelHeight - tileSize),
        size: tileSize * (0.6 + (i % 3) * 0.2),
      ));
    }
  }

  void _clearWorld() {
    world.removeAll(world.children);
  }

  void _createLevel() {
    final levelData = LevelData.getLevel(currentLevel);
    _updateLevelWidth(levelData.widthMultiplier);

    final groundY = levelHeight - tileSize;

    final ground = Ground(
      position: Vector2(0, groundY),
      size: Vector2(levelWidth, tileSize),
    );
    world.add(ground);

    player = Player(position: Vector2(tileSize * 3, groundY));
    world.add(player);

    double gapEndX = 0;

    for (final item in levelData.layout) {
      final x = item.x * tileSize;

      if (x < gapEndX) continue;

      switch (item.type) {
        case LevelItemType.platform:
          final height = item.height! * tileSize;
          final platY = groundY - height;
          world.add(Platform(position: Vector2(x, platY), size: Vector2(tileSize * 4, tileSize * 0.75)));
          world.add(Coin(position: Vector2(x + tileSize * 2, platY - tileSize * 0.5)));

        case LevelItemType.enemy:
          world.add(WalkingEnemy(position: Vector2(x, groundY)));

        case LevelItemType.gap:
          final width = item.width! * tileSize;
          gapEndX = x + width;

        case LevelItemType.coinRow:
          for (int i = 0; i < item.count!; i++) {
            world.add(Coin(position: Vector2(x + i * tileSize * 1.2, groundY - tileSize * 2)));
          }

        case LevelItemType.stair:
          for (int i = 0; i < item.steps!; i++) {
            world.add(Platform(
              position: Vector2(x + i * tileSize * 1.5, groundY - (i + 1) * tileSize * 0.8),
              size: Vector2(tileSize * 2, tileSize * 0.8),
            ));
          }

        case LevelItemType.powerupShield:
          world.add(PowerUp(position: Vector2(x, groundY - tileSize * 1.5), type: PowerUpType.shield));

        case LevelItemType.powerupSpeed:
          world.add(PowerUp(position: Vector2(x, groundY - tileSize * 1.5), type: PowerUpType.speed));
      }
    }

    world.add(Flag(position: Vector2(levelWidth - tileSize * 4, groundY)));

    camera.follow(player, horizontalOnly: true, snap: true);
    camera.viewfinder.position.y = levelHeight / 2;
    camera.setBounds(
      Rectangle.fromLTWH(0, 0, levelWidth, levelHeight),
      considerViewport: true,
    );
  }

  void loadNextLevel() {
    currentLevel++;
    if (currentLevel > LevelData.totalLevels) {
      gameState = GameState.gameOver;
      _checkHighScore();
      overlays.add(OverlayId.victory.name);
      return;
    }
    _clearWorld();
    _createBackground();
    _createLevel();
    gameState = GameState.playing;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update notification timer
    if (_notificationTimer > 0) {
      _notificationTimer -= dt;
      if (_notificationTimer <= 0) {
        activeNotification = null;
        _notificationTimer = 0;
      }
    }

    if (isPlaying) {
      // Don't interfere during death animation
      if (player.state == PlayerState.dying) return;

      if (player.position.y > levelHeight + tileSize * 3) {
        // Fell into void — skip animation, resolve directly
        resolvePlayerDeath();
      }

      player.position.x = player.position.x.clamp(0.0, levelWidth - player.size.x);
    }
  }

  void playerDied() {
    if (player.state == PlayerState.dying) return;
    player.startDeathAnimation();
  }

  void resolvePlayerDeath() {
    lives--;
    if (lives > 0) {
      player.resetGame();
    } else {
      gameState = GameState.gameOver;
      _checkHighScore();
      overlays.add(OverlayId.gameOver.name);
    }
  }

  void playerHitEnemy() => score += GameConstants.enemyScore;
  void collectCoin() {
    coins++;
    score += GameConstants.coinScore;
  }

  void completeLevel() {
    if (gameState == GameState.levelComplete) return;
    gameState = GameState.levelComplete;
    _checkHighScore();
    overlays.add(OverlayId.levelComplete.name);
  }

  void _checkHighScore() {
    if (score > highScore) {
      highScore = score;
      HighScoreService.saveHighScore(score);
    }
  }

  void restart() {
    score = 0;
    coins = 0;
    lives = GameConstants.maxLives;
    currentLevel = 1;
    gameState = GameState.playing;
    _clearWorld();
    _createBackground();
    _createLevel();
    overlays.remove(OverlayId.gameOver.name);
    overlays.remove(OverlayId.levelComplete.name);
    overlays.remove(OverlayId.victory.name);
  }

  void startGame() {
    gameState = GameState.playing;
    restart();
    overlays.remove(OverlayId.mainMenu.name);
  }

  void pauseGame() {
    gameState = GameState.paused;
    overlays.add(OverlayId.pauseMenu.name);
  }

  void resumeGame() {
    gameState = GameState.playing;
    overlays.remove(OverlayId.pauseMenu.name);
  }
}

class Mountain extends PositionComponent {
  Mountain({required Vector2 position, required double height, required double width, required this.color})
    : super(position: position, size: Vector2(width, height), anchor: Anchor.bottomCenter);

  final Color color;

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, size.y)
      ..lineTo(size.x / 2, 0)
      ..lineTo(size.x, size.y)
      ..close();
    canvas.drawPath(path, paint);

    final snowPaint = Paint()..color = Colors.white;
    final snowPath = Path()
      ..moveTo(size.x * 0.35, size.y * 0.4)
      ..lineTo(size.x / 2, 0)
      ..lineTo(size.x * 0.65, size.y * 0.4)
      ..close();
    canvas.drawPath(snowPath, snowPaint);
  }
}

class Cloud extends PositionComponent with HasGameReference<PixelAdventureGame> {
  Cloud({required super.position}) : super(size: Vector2(60, 30));

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.9);
    canvas.drawOval(const Rect.fromLTWH(0, 8, 30, 18), paint);
    canvas.drawOval(const Rect.fromLTWH(15, 0, 35, 22), paint);
    canvas.drawOval(const Rect.fromLTWH(40, 8, 20, 14), paint);
  }

  @override
  void update(double dt) {
    position.x += 5 * dt;
    if (position.x > game.levelWidth + 100) position.x = -80;
  }
}

class Bush extends PositionComponent {
  Bush({required Vector2 position, required double size})
    : super(position: position, size: Vector2(size * 2, size), anchor: Anchor.bottomCenter);

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFF388E3C);
    canvas.drawOval(Rect.fromLTWH(0, size.y * 0.3, size.x * 0.6, size.y * 0.7), paint);
    canvas.drawOval(Rect.fromLTWH(size.x * 0.3, 0, size.x * 0.5, size.y), paint);
    canvas.drawOval(Rect.fromLTWH(size.x * 0.5, size.y * 0.4, size.x * 0.5, size.y * 0.7), paint);
  }
}
