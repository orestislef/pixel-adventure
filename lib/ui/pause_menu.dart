import 'package:flutter/material.dart';
import '../game/pixel_adventure_game.dart';
import '../utils/constants.dart';

class PauseMenu extends StatelessWidget {
  final PixelAdventureGame game;
  
  const PauseMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 500;
    
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Container(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
              border: Border.all(color: Colors.white24, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.pause_circle_filled,
                  color: Colors.amber,
                  size: isSmallScreen ? 40 : 56,
                ),
                SizedBox(height: isSmallScreen ? 8 : 12),
                Text(
                  'PAUSED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 16 : 24),
                _buildResumeButton(isSmallScreen),
                SizedBox(height: isSmallScreen ? 10 : 14),
                _buildRestartButton(isSmallScreen),
                SizedBox(height: isSmallScreen ? 10 : 14),
                _buildScoreDisplay(isSmallScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildResumeButton(bool isSmall) {
    return ElevatedButton.icon(
      onPressed: () {
        game.resumeGame();
      },
      icon: Icon(Icons.play_arrow, size: isSmall ? 20 : 24),
      label: Text(
        'RESUME',
        style: TextStyle(fontSize: isSmall ? 14 : 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 28, vertical: isSmall ? 10 : 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  Widget _buildRestartButton(bool isSmall) {
    return ElevatedButton.icon(
      onPressed: () {
        game.overlays.remove(OverlayId.pauseMenu.name);
        game.restart();
      },
      icon: Icon(Icons.refresh, size: isSmall ? 20 : 24),
      label: Text(
        'RESTART',
        style: TextStyle(fontSize: isSmall ? 14 : 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 28, vertical: isSmall ? 10 : 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  Widget _buildScoreDisplay(bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 10 : 14),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.stars, color: Colors.amber, size: isSmall ? 16 : 18),
              const SizedBox(width: 6),
              Text(
                'Score: ${game.score}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmall ? 14 : 16,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmall ? 4 : 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.monetization_on, color: Colors.yellow, size: isSmall ? 16 : 18),
              const SizedBox(width: 6),
              Text(
                'Coins: ${game.coins}',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: isSmall ? 12 : 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
