import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../game/pixel_adventure_game.dart';
import '../utils/constants.dart';

class HUD extends StatefulWidget {
  final PixelAdventureGame game;

  const HUD({super.key, required this.game});

  @override
  State<HUD> createState() => _HUDState();
}

class _HUDState extends State<HUD> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  PixelAdventureGame get game => widget.game;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => setState(() {}));
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmall = screenHeight < 500;
    final btnSize = isSmall ? 56.0 : 66.0;
    final jumpWidth = isSmall ? 72.0 : 86.0;
    final iconSize = isSmall ? 32.0 : 40.0;
    final edgePad = screenWidth * 0.03;

    return SafeArea(
      child: Stack(
        children: [
          // Top-left: score, coins, lives
          Positioned(
            top: 8,
            left: 8,
            child: _buildInfo(isSmall),
          ),
          // Top-right: pause button
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                if (game.isPlaying) game.pauseGame();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.pause, color: Colors.white, size: isSmall ? 20 : 24),
              ),
            ),
          ),
          // Bottom-left: movement buttons
          Positioned(
            bottom: isSmall ? 12 : 20,
            left: edgePad,
            child: Row(
              children: [
                _ControlButton(
                  icon: Icons.arrow_left,
                  size: btnSize,
                  iconSize: iconSize,
                  onTapDown: () => game.player.moveLeft = true,
                  onTapUp: () => game.player.moveLeft = false,
                ),
                SizedBox(width: isSmall ? 8 : 12),
                _ControlButton(
                  icon: Icons.arrow_right,
                  size: btnSize,
                  iconSize: iconSize,
                  onTapDown: () => game.player.moveRight = true,
                  onTapUp: () => game.player.moveRight = false,
                ),
              ],
            ),
          ),
          // Bottom-right: jump button
          Positioned(
            bottom: isSmall ? 12 : 20,
            right: edgePad,
            child: _ControlButton(
              icon: Icons.arrow_upward,
              width: jumpWidth,
              size: btnSize,
              iconSize: iconSize,
              color: Colors.blue.withValues(alpha: 0.6),
              onTapDown: () => game.player.jumpPressed = true,
              onTapUp: () => game.player.jumpPressed = false,
            ),
          ),
          // Power-up notification (center top)
          if (game.activeNotification != null)
            Positioned(
              top: isSmall ? 36 : 48,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: isSmall ? 14 : 20, vertical: isSmall ? 6 : 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber, width: 1.5),
                  ),
                  child: Text(
                    game.activeNotification!,
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: isSmall ? 13 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          // Active power-up indicators (top-center)
          if (game.player.hasShield || game.player.hasSpeedBoost)
            Positioned(
              top: isSmall ? 4 : 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (game.player.hasShield)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: isSmall ? 10 : 14, vertical: isSmall ? 3 : 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shield, color: Colors.white, size: isSmall ? 14 : 18),
                          const SizedBox(width: 4),
                          Text(
                            'Shield',
                            style: TextStyle(color: Colors.white, fontSize: isSmall ? 12 : 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  if (game.player.hasShield && game.player.hasSpeedBoost) const SizedBox(width: 8),
                  if (game.player.hasSpeedBoost)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: isSmall ? 10 : 14, vertical: isSmall ? 3 : 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.flash_on, color: Colors.white, size: isSmall ? 14 : 18),
                          const SizedBox(width: 4),
                          Text(
                            '${game.player.speedBoostTimeLeft.ceil()}s',
                            style: TextStyle(color: Colors.white, fontSize: isSmall ? 12 : 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfo(bool isSmall) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 12, vertical: isSmall ? 4 : 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Score: ${game.score}',
            style: TextStyle(color: Colors.white, fontSize: isSmall ? 11 : 14),
          ),
          SizedBox(width: isSmall ? 8 : 12),
          Text(
            'Coins: ${game.coins}',
            style: TextStyle(color: Colors.yellow, fontSize: isSmall ? 11 : 14),
          ),
          SizedBox(width: isSmall ? 8 : 12),
          ...List.generate(
            GameConstants.maxLives,
            (i) => Icon(
              Icons.favorite,
              color: i < game.lives ? Colors.red : Colors.grey,
              size: isSmall ? 13 : 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatefulWidget {
  final IconData icon;
  final double size;
  final double? width;
  final double iconSize;
  final Color? color;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;

  const _ControlButton({
    required this.icon,
    required this.size,
    this.width,
    required this.iconSize,
    this.color,
    this.onTapDown,
    this.onTapUp,
  });

  @override
  State<_ControlButton> createState() => _ControlButtonState();
}

class _ControlButtonState extends State<_ControlButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color ?? Colors.black.withValues(alpha: 0.5);

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressed = true);
        widget.onTapDown?.call();
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTapUp?.call();
      },
      onTapCancel: () {
        setState(() => _pressed = false);
        widget.onTapUp?.call();
      },
      child: Container(
        width: widget.width ?? widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _pressed ? baseColor.withValues(alpha: 0.8) : baseColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withValues(alpha: _pressed ? 0.4 : 0.2),
            width: 1.5,
          ),
        ),
        child: Icon(widget.icon, color: Colors.white, size: widget.iconSize),
      ),
    );
  }
}
