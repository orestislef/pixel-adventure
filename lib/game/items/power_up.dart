import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class PowerUp extends PositionComponent {
  PowerUp({required Vector2 position, required this.type}) : super(
    position: position,
    size: Vector2(24, 24),
    anchor: Anchor.bottomCenter,
  );

  final PowerUpType type;
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

    final bob = sin(_animationTime * 3) * 3;
    final pulse = 0.9 + 0.1 * sin(_animationTime * 5);

    final Color bgColor;
    final Color iconColor;
    switch (type) {
      case PowerUpType.shield:
        bgColor = const Color(0xFF2196F3);
        iconColor = Colors.white;
      case PowerUpType.speed:
        bgColor = const Color(0xFFFFC107);
        iconColor = const Color(0xFFFF6F00);
    }

    // Glow
    final glowPaint = Paint()
      ..color = bgColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2 + bob),
      14 * pulse,
      glowPaint,
    );

    // Background circle
    final bgPaint = Paint()..color = bgColor;
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2 + bob),
      11 * pulse,
      bgPaint,
    );

    // Border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2 + bob),
      11 * pulse,
      borderPaint,
    );

    final iconPaint = Paint()..color = iconColor;
    final cx = size.x / 2;
    final cy = size.y / 2 + bob;

    switch (type) {
      case PowerUpType.shield:
        // Shield shape
        final path = Path()
          ..moveTo(cx, cy - 7)
          ..lineTo(cx + 6, cy - 3)
          ..lineTo(cx + 5, cy + 4)
          ..lineTo(cx, cy + 7)
          ..lineTo(cx - 5, cy + 4)
          ..lineTo(cx - 6, cy - 3)
          ..close();
        canvas.drawPath(path, iconPaint);
      case PowerUpType.speed:
        // Lightning bolt
        final path = Path()
          ..moveTo(cx + 1, cy - 7)
          ..lineTo(cx - 3, cy)
          ..lineTo(cx, cy)
          ..lineTo(cx - 1, cy + 7)
          ..lineTo(cx + 3, cy)
          ..lineTo(cx, cy)
          ..close();
        canvas.drawPath(path, iconPaint);
    }
  }
}
