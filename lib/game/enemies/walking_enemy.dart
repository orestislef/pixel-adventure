import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../pixel_adventure_game.dart';

class WalkingEnemy extends PositionComponent with HasGameReference<PixelAdventureGame> {
  WalkingEnemy({required Vector2 position}) : super(
    position: position,
    size: Vector2.all(28),
    anchor: Anchor.bottomLeft,
  );
  
  bool isDead = false;
  double _moveDirection = -1;
  double _animationTime = 0;
  
  double get _moveSpeed => game.tileSize * 2.0;
  
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (isDead) return;
    
    position.x += _moveDirection * _moveSpeed * dt;
    _animationTime += dt;
    
    if (position.x < game.tileSize * 2) {
      position.x = game.tileSize * 2;
      reverseDirection();
    }
    if (position.x > game.levelWidth - game.tileSize * 3) {
      position.x = game.levelWidth - game.tileSize * 3;
      reverseDirection();
    }
  }
  
  void reverseDirection() {
    _moveDirection *= -1;
  }
  
  void kill() {
    isDead = true;
    removeFromParent();
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    if (isDead) return;
    
    final bounce = sin(_animationTime * 8) * 2;
    
    final bodyPaint = Paint()..color = const Color(0xFF8B0000);
    canvas.drawOval(
      Rect.fromLTWH(0, -size.y + 4 + bounce, size.x, size.y * 0.75),
      bodyPaint,
    );
    
    final eyePaint = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(Offset(8, -size.y + 14 + bounce), 4, eyePaint);
    canvas.drawCircle(Offset(20, -size.y + 14 + bounce), 4, eyePaint);
    
    final pupilPaint = Paint()..color = const Color(0xFF000000);
    canvas.drawCircle(Offset(8 + _moveDirection * 2, -size.y + 14 + bounce), 2, pupilPaint);
    canvas.drawCircle(Offset(20 + _moveDirection * 2, -size.y + 14 + bounce), 2, pupilPaint);
    
    final footPaint = Paint()..color = const Color(0xFF5C0000);
    canvas.drawOval(
      Rect.fromLTWH(2, -6 + bounce, size.x / 3, 8),
      footPaint,
    );
    canvas.drawOval(
      Rect.fromLTWH(size.x / 2, -6 + bounce, size.x / 3, 8),
      footPaint,
    );
  }
}
