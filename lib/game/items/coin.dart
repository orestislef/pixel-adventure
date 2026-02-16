import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Coin extends PositionComponent {
  Coin({required Vector2 position}) : super(
    position: position,
    size: Vector2(16, 16),
    anchor: Anchor.bottomCenter,
  );
  
  bool isCollected = false;
  double _animationTime = 0;
  
  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    _animationTime += dt;
  }
  
  void collect() {
    if (!isCollected) {
      isCollected = true;
      removeFromParent();
    }
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    if (isCollected) return;
    
    final scale = 0.8 + 0.2 * sin(_animationTime * 4);
    
    final paint = Paint()..color = const Color(0xFFFFD700);
    final shadowPaint = Paint()..color = const Color(0xFFFFA000);
    
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.x / 2, -size.y / 2),
        width: 14 * scale,
        height: 14,
      ),
      shadowPaint,
    );
    
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.x / 2, -size.y / 2 - 1),
        width: 12 * scale,
        height: 12,
      ),
      paint,
    );
    
    final shinePaint = Paint()..color = const Color(0xFFFFFF00);
    canvas.drawCircle(Offset(size.x / 2 - 2, -size.y / 2 - 3), 2, shinePaint);
  }
}
