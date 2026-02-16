import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';
import 'game/pixel_adventure_game.dart';
import 'ui/hud.dart';
import 'ui/main_menu.dart';
import 'ui/pause_menu.dart';
import 'ui/game_over.dart';
import 'ui/level_complete.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  runApp(const PixelAdventureApp());
}

class PixelAdventureApp extends StatelessWidget {
  const PixelAdventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Adventure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late PixelAdventureGame game;
  
  @override
  void initState() {
    super.initState();
    game = PixelAdventureGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<PixelAdventureGame>(
        game: game,
        overlayBuilderMap: {
          'hud': (context, game) => HUD(game: game),
          'mainMenu': (context, game) => MainMenu(game: game),
          'pauseMenu': (context, game) => PauseMenu(game: game),
          'gameOver': (context, game) => GameOverScreen(game: game),
          'levelComplete': (context, game) => LevelCompleteScreen(game: game),
        },
        initialActiveOverlays: const ['mainMenu'],
      ),
    );
  }
}
