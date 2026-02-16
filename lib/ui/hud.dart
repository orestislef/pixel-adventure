import 'package:flutter/material.dart';
import '../game/pixel_adventure_game.dart';
import '../utils/constants.dart';

class HUD extends StatelessWidget {
  final PixelAdventureGame game;
  
  const HUD({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child: _buildInfo(),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: _buildControls(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Score: ${game.score}',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(width: 12),
          Text(
            'Coins: ${game.coins}',
            style: const TextStyle(color: Colors.yellow, fontSize: 14),
          ),
          const SizedBox(width: 12),
          ...List.generate(
            GameConstants.maxLives,
            (i) => Icon(
              Icons.favorite,
              color: i < game.lives ? Colors.red : Colors.grey,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ControlButton(
          icon: Icons.arrow_left,
          onTapDown: () => game.player.moveLeft = true,
          onTapUp: () => game.player.moveLeft = false,
        ),
        const SizedBox(width: 16),
        _ControlButton(
          label: 'JUMP',
          color: Colors.blue.withValues(alpha: 0.6),
          onTapDown: () => game.player.jumpPressed = true,
        ),
        const SizedBox(width: 16),
        _ControlButton(
          icon: Icons.arrow_right,
          onTapDown: () => game.player.moveRight = true,
          onTapUp: () => game.player.moveRight = false,
        ),
      ],
    );
  }
}

class _ControlButton extends StatefulWidget {
  final IconData? icon;
  final String? label;
  final Color? color;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  
  const _ControlButton({
    this.icon,
    this.label,
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
        width: widget.label != null ? 80 : 70,
        height: 70,
        decoration: BoxDecoration(
          color: (widget.color ?? Colors.black.withValues(alpha: 0.5)).withValues(alpha: _pressed ? 0.8 : null),
          borderRadius: BorderRadius.circular(12),
        ),
        child: widget.icon != null
            ? Icon(widget.icon, color: Colors.white, size: 40)
            : Center(
                child: Text(
                  widget.label!,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
