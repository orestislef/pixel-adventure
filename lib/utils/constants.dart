class GameConstants {
  static const double tileSize = 32.0;
  static const double pixelsPerMeter = 32.0;
  
  static const double gravity = 10.0;
  static const double playerSpeed = 200.0;
  static const double playerRunSpeed = 280.0;
  static const double jumpForce = 420.0;
  static const double maxJumpTime = 0.35;
  
  static const int maxLives = 3;
  static const double playerWidth = 24.0;
  static const double playerHeight = 32.0;
  
  static const double enemySpeed = 60.0;
  static const double enemySize = 28.0;
  
  static const int coinScore = 100;
  static const int enemyScore = 200;
  
  static const double cameraLerp = 0.1;
  static const double cameraLookAhead = 100.0;
}

enum GameState {
  menu,
  playing,
  paused,
  gameOver,
  levelComplete,
}

enum PlayerState {
  idle,
  running,
  jumping,
  falling,
  dead,
}

enum EnemyType {
  walking,
  jumping,
}
