import 'package:flutter/material.dart';
import '../game/pixel_adventure_game.dart';
import '../utils/constants.dart';

class VictoryScreen extends StatelessWidget {
  final PixelAdventureGame game;

  const VictoryScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 500;

    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Container(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.7), width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.military_tech,
                  color: Colors.amber,
                  size: isSmallScreen ? 56 : 72,
                ),
                SizedBox(height: isSmallScreen ? 8 : 12),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.amber, Colors.yellow, Colors.orange],
                  ).createShader(bounds),
                  child: Text(
                    'YOU WIN!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 4 : 8),
                Text(
                  'All levels completed!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isSmallScreen ? 14 : 16,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 12 : 18),
                _buildScoreDisplay(isSmallScreen),
                SizedBox(height: isSmallScreen ? 16 : 24),
                _buildPlayAgainButton(isSmallScreen),
                SizedBox(height: isSmallScreen ? 8 : 12),
                _buildMainMenuButton(isSmallScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreDisplay(bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          if (game.score >= game.highScore && game.score > 0)
            Padding(
              padding: EdgeInsets.only(bottom: isSmall ? 6 : 8),
              child: Text(
                'NEW HIGH SCORE!',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: isSmall ? 14 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Text(
            'FINAL SCORE',
            style: TextStyle(
              color: Colors.amber,
              fontSize: isSmall ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isSmall ? 4 : 6),
          Text(
            '${game.score}',
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmall ? 32 : 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isSmall ? 8 : 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, color: Colors.amber, size: isSmall ? 16 : 20),
              const SizedBox(width: 6),
              Text(
                'Best: ${game.highScore}',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: isSmall ? 14 : 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayAgainButton(bool isSmall) {
    return ElevatedButton.icon(
      onPressed: () {
        game.overlays.remove(OverlayId.victory.name);
        game.restart();
      },
      icon: Icon(Icons.replay, size: isSmall ? 20 : 24),
      label: Text(
        'PLAY AGAIN',
        style: TextStyle(fontSize: isSmall ? 14 : 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 32, vertical: isSmall ? 10 : 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildMainMenuButton(bool isSmall) {
    return TextButton.icon(
      onPressed: () {
        game.overlays.remove(OverlayId.victory.name);
        game.gameState = GameState.menu;
        game.overlays.add(OverlayId.mainMenu.name);
      },
      icon: Icon(Icons.home, color: Colors.white70, size: isSmall ? 16 : 20),
      label: Text(
        'Main Menu',
        style: TextStyle(color: Colors.white70, fontSize: isSmall ? 12 : 14),
      ),
    );
  }
}
