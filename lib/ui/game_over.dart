import 'package:flutter/material.dart';
import '../game/pixel_adventure_game.dart';
import '../utils/constants.dart';

class GameOverScreen extends StatelessWidget {
  final PixelAdventureGame game;
  
  const GameOverScreen({super.key, required this.game});

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
              borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 24),
              border: Border.all(color: Colors.red.withValues(alpha: 0.5), width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                  size: isSmallScreen ? 48 : 64,
                ),
                SizedBox(height: isSmallScreen ? 8 : 12),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.red, Colors.orange],
                  ).createShader(bounds),
                  child: Text(
                    'GAME OVER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 12 : 16),
                _buildFinalScore(isSmallScreen),
                SizedBox(height: isSmallScreen ? 16 : 24),
                _buildRetryButton(isSmallScreen),
                SizedBox(height: isSmallScreen ? 8 : 12),
                _buildMainMenuButton(isSmallScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFinalScore(bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
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
              Icon(Icons.monetization_on, color: Colors.yellow, size: isSmall ? 16 : 20),
              SizedBox(width: 6),
              Text(
                'Coins: ${game.coins}',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: isSmall ? 14 : 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildRetryButton(bool isSmall) {
    return ElevatedButton.icon(
      onPressed: () {
        game.overlays.remove('gameOver');
        game.restart();
      },
      icon: Icon(Icons.refresh, size: isSmall ? 20 : 24),
      label: Text(
        'TRY AGAIN',
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
        game.overlays.remove('gameOver');
        game.gameState = GameState.menu;
        game.overlays.add('mainMenu');
      },
      icon: Icon(Icons.home, color: Colors.white70, size: isSmall ? 16 : 20),
      label: Text(
        'Main Menu',
        style: TextStyle(color: Colors.white70, fontSize: isSmall ? 12 : 14),
      ),
    );
  }
}
