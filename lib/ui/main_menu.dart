import 'package:flutter/material.dart';
import '../game/pixel_adventure_game.dart';

class MainMenu extends StatelessWidget {
  final PixelAdventureGame game;
  
  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 500;
    
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(isSmallScreen),
              SizedBox(height: isSmallScreen ? 24 : 40),
              _buildPlayButton(context, isSmallScreen),
              if (game.highScore > 0) ...[
                SizedBox(height: isSmallScreen ? 10 : 14),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.emoji_events, color: Colors.amber, size: isSmallScreen ? 18 : 22),
                    const SizedBox(width: 6),
                    Text(
                      'HIGH SCORE: ${game.highScore}',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: isSmallScreen ? 16 : 24),
              _buildInstructions(isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTitle(bool isSmall) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.amber, Colors.orange, Colors.deepOrange],
          ).createShader(bounds),
          child: Text(
            'PIXEL',
            style: TextStyle(
              fontSize: isSmall ? 40 : 56,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 6,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  offset: Offset(3, 3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.lightBlue, Colors.blue, Colors.indigo],
          ).createShader(bounds),
          child: Text(
            'ADVENTURE',
            style: TextStyle(
              fontSize: isSmall ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 3,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPlayButton(BuildContext context, bool isSmall) {
    return ElevatedButton(
      onPressed: () {
        game.overlays.remove('mainMenu');
        game.startGame();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 32 : 40, vertical: isSmall ? 12 : 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
        elevation: 6,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow, size: isSmall ? 24 : 28),
          const SizedBox(width: 8),
          Text(
            'PLAY',
            style: TextStyle(
              fontSize: isSmall ? 18 : 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInstructions(bool isSmall) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 14 : 18),
      margin: EdgeInsets.symmetric(horizontal: isSmall ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          Text(
            'HOW TO PLAY',
            style: TextStyle(
              color: Colors.amber,
              fontSize: isSmall ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isSmall ? 8 : 12),
          _buildInstructionRow(Icons.arrow_left, Icons.arrow_right, 'Move', isSmall),
          SizedBox(height: isSmall ? 4 : 6),
          _buildInstructionRow(Icons.arrow_upward, null, 'Jump', isSmall),
          SizedBox(height: isSmall ? 4 : 6),
          _buildInstructionRow(Icons.monetization_on, null, 'Collect coins', isSmall),
          SizedBox(height: isSmall ? 4 : 6),
          _buildInstructionRow(Icons.flag, null, 'Reach the flag', isSmall),
        ],
      ),
    );
  }
  
  Widget _buildInstructionRow(IconData icon1, IconData? icon2, String text, bool isSmall) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon1, color: Colors.white, size: isSmall ? 14 : 18),
        if (icon2 != null) ...[
          Icon(icon2, color: Colors.white, size: isSmall ? 14 : 18),
        ],
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.white70, fontSize: isSmall ? 11 : 13)),
      ],
    );
  }
}
