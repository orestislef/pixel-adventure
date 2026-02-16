import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'player/player.dart';
import 'platforms/ground.dart';
import 'platforms/platform.dart';
import 'enemies/walking_enemy.dart';
import 'items/coin.dart';
import 'items/flag.dart';

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
  
  bool get isPlaying => gameState == GameState.playing;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    _calculateDimensions();
    
    camera.viewfinder.anchor = Anchor.center;
    
    debugPrint('=== GAME LOADED ===');
    debugPrint('Screen size: $size');
    debugPrint('Level: ${levelWidth}x$levelHeight, tileSize: $tileSize');
    
    _createBackground();
    _createLevel();
    
    overlays.add('hud');
  }
  
  void _calculateDimensions() {
    final screenHeight = size.y;
    final screenWidth = size.x;
    
    levelHeight = screenHeight * 0.92;
    tileSize = levelHeight / 12;
    levelWidth = screenWidth * 8;
  }
  
  void _createBackground() {
    final bg = RectangleComponent(
      size: Vector2(levelWidth, levelHeight),
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
  
  void _createLevel() {
    debugPrint('Creating level...');
    
    final groundY = levelHeight - tileSize;
    debugPrint('Ground Y: $groundY (ground top)');
    
    final ground = Ground(
      position: Vector2(0, groundY),
      size: Vector2(levelWidth, tileSize),
    );
    world.add(ground);

    player = Player(position: Vector2(tileSize * 3, groundY));
    world.add(player);
    
    final levelLayout = [
      {'x': 5, 'type': 'gap', 'width': 4},
      {'x': 12, 'type': 'platform', 'height': 2},
      {'x': 18, 'type': 'enemy'},
      {'x': 22, 'type': 'platform', 'height': 2.5},
      {'x': 26, 'type': 'coin_row', 'count': 3},
      {'x': 32, 'type': 'platform', 'height': 3},
      {'x': 38, 'type': 'enemy'},
      {'x': 42, 'type': 'gap', 'width': 5},
      {'x': 50, 'type': 'platform', 'height': 2},
      {'x': 56, 'type': 'stair', 'steps': 4},
      {'x': 66, 'type': 'enemy'},
      {'x': 70, 'type': 'platform', 'height': 3.5},
      {'x': 76, 'type': 'gap', 'width': 4},
      {'x': 84, 'type': 'platform', 'height': 2},
      {'x': 90, 'type': 'enemy'},
      {'x': 94, 'type': 'platform', 'height': 2.5},
      {'x': 100, 'type': 'coin_row', 'count': 5},
      {'x': 108, 'type': 'stair', 'steps': 5},
      {'x': 120, 'type': 'platform', 'height': 3},
      {'x': 126, 'type': 'enemy'},
      {'x': 130, 'type': 'gap', 'width': 6},
    ];
    
    double gapEndX = 0;
    
    for (final item in levelLayout) {
      final x = (item['x'] as num) * tileSize;
      final type = item['type'] as String;
      
      if (x < gapEndX) continue;
      
      switch (type) {
        case 'platform':
          final height = (item['height'] as num) * tileSize;
          final platY = groundY - height;
          world.add(Platform(position: Vector2(x, platY), size: Vector2(tileSize * 4, tileSize * 0.75)));
          world.add(Coin(position: Vector2(x + tileSize * 2, platY - tileSize * 0.5)));
          break;

        case 'enemy':
          world.add(WalkingEnemy(position: Vector2(x, groundY)));
          break;

        case 'gap':
          final width = (item['width'] as num) * tileSize;
          gapEndX = x + width;
          break;

        case 'coin_row':
          final count = item['count'] as int;
          for (int i = 0; i < count; i++) {
            world.add(Coin(position: Vector2(x + i * tileSize * 1.2, groundY - tileSize * 2)));
          }
          break;

        case 'stair':
          final steps = item['steps'] as int;
          for (int i = 0; i < steps; i++) {
            world.add(Platform(
              position: Vector2(x + i * tileSize * 1.5, groundY - (i + 1) * tileSize * 0.8),
              size: Vector2(tileSize * 2, tileSize * 0.8),
            ));
          }
          break;
      }
    }
    
    world.add(Flag(position: Vector2(levelWidth - tileSize * 4, groundY)));

    camera.follow(player, horizontalOnly: true, snap: true);
    camera.viewfinder.position.y = levelHeight / 2;
    camera.setBounds(
      Rectangle.fromLTWH(0, 0, levelWidth, levelHeight),
      considerViewport: true,
    );
    
    debugPrint('Player created at: ${player.position}');
    debugPrint('Player size: ${player.size}');
    debugPrint('Level width: $levelWidth');
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (isPlaying) {
      if (player.position.y > levelHeight + tileSize * 3) {
        _playerDied();
      }
      
      player.position.x = player.position.x.clamp(0.0, levelWidth - player.size.x);
    }
  }
  
  void _playerDied() {
    lives--;
    if (lives > 0) {
      player.resetGame();
    } else {
      gameState = GameState.gameOver;
      overlays.add('gameOver');
    }
  }
  
  void playerHitEnemy() => score += GameConstants.enemyScore;
  void collectCoin() {
    coins++;
    score += GameConstants.coinScore;
  }
  void completeLevel() {
    gameState = GameState.levelComplete;
    overlays.add('levelComplete');
  }
  
  void restart() {
    score = 0;
    coins = 0;
    lives = GameConstants.maxLives;
    gameState = GameState.playing;
    player.resetGame();
    overlays.remove('gameOver');
    overlays.remove('levelComplete');
  }
  
  void startGame() {
    gameState = GameState.playing;
    restart();
    overlays.remove('mainMenu');
  }
  
  void pauseGame() {
    gameState = GameState.paused;
    overlays.add('pauseMenu');
  }
  
  void resumeGame() {
    gameState = GameState.playing;
    overlays.remove('pauseMenu');
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
