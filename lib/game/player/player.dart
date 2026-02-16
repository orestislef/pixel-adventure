import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../pixel_adventure_game.dart';
import '../platforms/ground.dart';
import '../platforms/platform.dart';
import '../enemies/walking_enemy.dart';
import '../items/coin.dart';
import '../items/flag.dart';

class Player extends PositionComponent with CollisionCallbacks, HasGameReference<PixelAdventureGame>, KeyboardHandler {
  Player({required Vector2 position}) : super(
    position: position,
    size: Vector2(24, 32),
    anchor: Anchor.bottomLeft,
  );
  
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool isFacingRight = true;
  bool isDead = false;
  bool _isJumping = false;
  double _jumpTime = 0;
  int _groundContactCount = 0;
  
  PlayerState state = PlayerState.idle;
  
  bool moveLeft = false;
  bool moveRight = false;
  bool jumpPressed = false;
  
  double get _moveSpeed => game.tileSize * 6.0;
  double get _jumpForce => game.tileSize * 14.0;
  
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    debugPrint('Player pos: $position, size: $size, anchor: $anchor');
  }
  
  void resetGame() {
    final groundY = game.levelHeight - game.tileSize;
    position = Vector2(game.tileSize * 3, groundY);
    velocity = Vector2.zero();
    isDead = false;
    isOnGround = false;
    _isJumping = false;
    _groundContactCount = 0;
  }
  
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    moveLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA);
    moveRight = keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD);
    jumpPressed = keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW);
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (isDead || !game.isPlaying) return;
    
    _updateMovement(dt);
    _updateJump(dt);
    _applyGravity(dt);
    _updatePosition(dt);
    _updateState();
  }
  
  void _updateMovement(double dt) {
    velocity.x = 0;
    if (moveLeft) { velocity.x = -_moveSpeed; isFacingRight = false; }
    if (moveRight) { velocity.x = _moveSpeed; isFacingRight = true; }
  }
  
  void _updateJump(double dt) {
    if (jumpPressed && isOnGround && !_isJumping) {
      _isJumping = true;
      _jumpTime = 0;
      velocity.y = -_jumpForce;
      isOnGround = false;
      _groundContactCount = 0;
    }
    
    if (_isJumping) {
      _jumpTime += dt;
      if (_jumpTime > GameConstants.maxJumpTime || !jumpPressed) {
        _isJumping = false;
      }
    }
  }
  
  void _applyGravity(double dt) {
    if (!isOnGround) {
      velocity.y += GameConstants.gravity * 80 * dt;
      velocity.y = velocity.y.clamp(-500.0, 500.0);
    }
  }
  
  void _updatePosition(double dt) {
    position.x += velocity.x * dt;
    position.y += velocity.y * dt;
  }
  
  void _updateState() {
    if (!isOnGround) {
      state = velocity.y < 0 ? PlayerState.jumping : PlayerState.falling;
    } else {
      state = velocity.x.abs() > 1 ? PlayerState.running : PlayerState.idle;
    }
  }
  
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (isDead) return;

    if (other is Ground || other is Platform) {
      _groundContactCount++;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (isDead) return;

    if (other is Ground || other is Platform) {
      _handleGroundCollision(other);
    }

    if (other is WalkingEnemy && !other.isDead) {
      _handleEnemyCollision(other);
    }

    if (other is Coin && !other.isCollected) {
      other.collect();
      game.collectCoin();
    }

    if (other is Flag) {
      game.completeLevel();
    }
  }

  void _handleGroundCollision(PositionComponent other) {
    final otherTop = other.position.y;

    if (velocity.y >= 0) {
      final wasAbove = bottomY <= otherTop + velocity.y.abs() * 0.1 + 5;

      if (wasAbove && bottomY >= otherTop - 10) {
        position.y = otherTop;
        velocity.y = 0;
        isOnGround = true;
        _isJumping = false;
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Ground || other is Platform) {
      _groundContactCount--;
      if (_groundContactCount <= 0) {
        _groundContactCount = 0;
        isOnGround = false;
      }
    }
  }
  
  void _handleEnemyCollision(WalkingEnemy enemy) {
    final enemyTop = enemy.position.y - enemy.size.y;
    final enemyCenterX = enemy.position.x + enemy.size.x / 2;
    
    final isAboveEnemy = bottomY <= enemyTop + enemy.size.y * 0.4;
    final isCenteredOverEnemy = (centerX - enemyCenterX).abs() < enemy.size.x * 0.7;
    final isFalling = velocity.y > 0;
    
    if (isAboveEnemy && isCenteredOverEnemy && isFalling) {
      enemy.kill();
      game.playerHitEnemy();
      velocity.y = -game.tileSize * 6;
      isOnGround = false;
    } else {
      game.lives--;
      if (game.lives <= 0) {
        game.gameState = GameState.gameOver;
        game.overlays.add('gameOver');
      } else {
        resetGame();
      }
    }
  }
  
  double get bottomY => position.y;
  double get topY => position.y - size.y;
  double get leftX => position.x;
  double get rightX => position.x + size.x;
  double get centerX => position.x + size.x / 2;
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    canvas.save();
    if (!isFacingRight) {
      canvas.scale(-1, 1);
      canvas.translate(-size.x, 0);
    }
    
    final bodyPaint = Paint()..color = const Color(0xFF2196F3);
    canvas.drawRect(Rect.fromLTWH(3, 0, 18, 20), bodyPaint);

    final headPaint = Paint()..color = const Color(0xFFFFCC80);
    canvas.drawRect(Rect.fromLTWH(5, 0, 14, 12), headPaint);

    final hatPaint = Paint()..color = const Color(0xFFFF5722);
    canvas.drawRect(Rect.fromLTWH(4, 0, 16, 5), hatPaint);

    final eyePaint = Paint()..color = const Color(0xFF000000);
    canvas.drawRect(const Rect.fromLTWH(7, 6, 2, 2), eyePaint);
    canvas.drawRect(const Rect.fromLTWH(12, 6, 2, 2), eyePaint);

    final legPaint = Paint()..color = const Color(0xFF1565C0);
    canvas.drawRect(const Rect.fromLTWH(4, 20, 6, 12), legPaint);
    canvas.drawRect(const Rect.fromLTWH(14, 20, 6, 12), legPaint);
    
    canvas.restore();
  }
}
