import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Flag extends PositionComponent {
  Flag({required Vector2 position}) : super(
    position: position,
    size: Vector2(40, 96),
    anchor: Anchor.bottomLeft,
  );
  
  double _waveTime = 0;
  
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    _waveTime += dt;
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final polePaint = Paint()..color = const Color(0xFF424242);
    canvas.drawRect(
      Rect.fromLTWH(5, 0, 6, size.y),
      polePaint,
    );

    final ballPaint = Paint()..color = const Color(0xFFFFD700);
    canvas.drawCircle(const Offset(8, 0), 8, ballPaint);

    final wave = sin(_waveTime * 3) * 3;
    final flagPaint = Paint()..color = const Color(0xFFFF5252);

    final path = Path()
      ..moveTo(11, 8)
      ..lineTo(40 + wave, 16 + wave / 2)
      ..lineTo(40 + wave * 0.5, 40)
      ..lineTo(11, 48)
      ..close();

    canvas.drawPath(path, flagPaint);

    final starPaint = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(Offset(26 + wave * 0.7, 28), 5, starPaint);

    final basePaint = Paint()..color = const Color(0xFF795548);
    canvas.drawRect(
      Rect.fromLTWH(0, size.y - 8, 16, 8),
      basePaint,
    );
  }
}
