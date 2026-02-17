class GameConstants {
  static const double gravity = 10.0;
  static const double maxJumpTime = 0.35;

  static const int maxLives = 3;

  static const int coinScore = 100;
  static const int enemyScore = 200;

  static const double speedBoostDuration = 5.0;
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
  dying,
  dead,
}

enum PowerUpType {
  shield,
  speed,
}

enum OverlayId {
  hud,
  mainMenu,
  pauseMenu,
  gameOver,
  levelComplete,
  victory,
}

enum LevelItemType {
  platform,
  enemy,
  gap,
  coinRow,
  stair,
  powerupShield,
  powerupSpeed,
}
