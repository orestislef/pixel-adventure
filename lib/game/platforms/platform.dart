import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../pixel_adventure_game.dart';

class Platform extends PositionComponent with HasGameReference<PixelAdventureGame> {
  Platform({required Vector2 position, required Vector2 size}) : super(
    position: position,
    size: size,
    anchor: Anchor.topLeft,
  );
  
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }
  
  double get topY => position.y;
  
  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFF8B4513);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
    
    final topPaint = Paint()..color = const Color(0xFFA0522D);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, 4), topPaint);
    
    final grassPaint = Paint()..color = const Color(0xFF4CAF50);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, 6), grassPaint);
    
    final brickPaint = Paint()..color = const Color(0xFF6D4C41);
    final brickCount = (size.x / 16).floor();
    for (int i = 0; i < brickCount; i++) {
      canvas.drawRect(Rect.fromLTWH(i * 16.0 + 2, 8.0, 12.0, 10.0), brickPaint);
    }
  }
}
