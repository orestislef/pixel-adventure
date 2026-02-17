import 'package:flutter/material.dart';
import '../game/pixel_adventure_game.dart';
import '../utils/constants.dart';

class HUD extends StatelessWidget {
  final PixelAdventureGame game;

  const HUD({super.key, required this.game});

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
