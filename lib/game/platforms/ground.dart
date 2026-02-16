import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../pixel_adventure_game.dart';

class Ground extends PositionComponent with HasGameReference<PixelAdventureGame> {
  Ground({required Vector2 position, required Vector2 size}) : super(
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
    final paint = Paint()..color = const Color(0xFF4CAF50);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
    
    final grassPaint = Paint()..color = const Color(0xFF66BB6A);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, 8), grassPaint);
    
    final dirtPaint = Paint()..color = const Color(0xFF8B4513);
    final dirtCount = (size.x / 32).floor();
    for (int i = 0; i < dirtCount; i++) {
      canvas.drawRect(Rect.fromLTWH(i * 32.0 + 8, 16.0, 16.0, 16.0), dirtPaint);
    }
  }
}
