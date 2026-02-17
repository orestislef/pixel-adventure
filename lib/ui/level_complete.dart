import 'package:flutter/material.dart';
import '../game/pixel_adventure_game.dart';
import '../utils/constants.dart';

class LevelCompleteScreen extends StatelessWidget {
  final PixelAdventureGame game;
  
  const LevelCompleteScreen({super.key, required this.game});

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
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: isSmallScreen ? 48 : 64,
                ),
                SizedBox(height: isSmallScreen ? 8 : 12),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.amber, Colors.yellow, Colors.orange],
                  ).createShader(bounds),
                  child: Text(
                    'LEVEL COMPLETE!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 22 : 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 4 : 6),
                Text(
                  'Level ${game.currentLevel}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isSmallScreen ? 14 : 16,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 12 : 18),
                _buildScoreBreakdown(isSmallScreen),
                SizedBox(height: isSmallScreen ? 16 : 24),
                _buildContinueButton(isSmallScreen),
                SizedBox(height: isSmallScreen ? 8 : 12),
                _buildMainMenuButton(isSmallScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildScoreBreakdown(bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          _buildScoreRow(
            icon: Icons.monetization_on,
            iconColor: Colors.yellow,
            label: 'Coins',
            value: '${game.coins} x ${GameConstants.coinScore}',
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 8 : 10),
          _buildScoreRow(
            icon: Icons.star,
            iconColor: Colors.amber,
            label: 'Total Score',
            value: '${game.score}',
            isTotal: true,
            isSmall: isSmall,
          ),
        ],
      ),
    );
  }
  
  Widget _buildScoreRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    bool isTotal = false,
    bool isSmall = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: isTotal ? (isSmall ? 20 : 24) : (isSmall ? 18 : 20)),
        SizedBox(width: isSmall ? 8 : 10),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: isTotal ? (isSmall ? 14 : 16) : (isSmall ? 12 : 14),
          ),
        ),
        SizedBox(width: isSmall ? 10 : 14),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: isTotal ? (isSmall ? 18 : 22) : (isSmall ? 14 : 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildContinueButton(bool isSmall) {
    return ElevatedButton.icon(
      onPressed: () {
        game.overlays.remove(OverlayId.levelComplete.name);
        game.loadNextLevel();
      },
      icon: Icon(Icons.arrow_forward, size: isSmall ? 20 : 24),
      label: Text(
        'NEXT LEVEL',
        style: TextStyle(fontSize: isSmall ? 14 : 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 28 : 36, vertical: isSmall ? 10 : 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
  
  Widget _buildMainMenuButton(bool isSmall) {
    return TextButton.icon(
      onPressed: () {
        game.overlays.remove(OverlayId.levelComplete.name);
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
