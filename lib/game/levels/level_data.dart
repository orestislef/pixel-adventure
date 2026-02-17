class LevelData {
  final String name;
  final double widthMultiplier;
  final List<Map<String, dynamic>> layout;

  const LevelData({
    required this.name,
    required this.widthMultiplier,
    required this.layout,
  });

  static const int totalLevels = 3;

  static LevelData getLevel(int number) {
    switch (number) {
      case 1:
        return _level1;
      case 2:
        return _level2;
      case 3:
        return _level3;
      default:
        return _level1;
    }
  }

  static const _level1 = LevelData(
    name: 'Green Hills',
    widthMultiplier: 8,
    layout: [
      {'x': 5, 'type': 'gap', 'width': 4},
      {'x': 12, 'type': 'platform', 'height': 2},
      {'x': 18, 'type': 'enemy'},
      {'x': 22, 'type': 'platform', 'height': 2.5},
      {'x': 26, 'type': 'coin_row', 'count': 3},
      {'x': 32, 'type': 'platform', 'height': 3},
      {'x': 38, 'type': 'enemy'},
      {'x': 42, 'type': 'gap', 'width': 5},
      {'x': 50, 'type': 'platform', 'height': 2},
      {'x': 56, 'type': 'stair', 'steps': 4},
      {'x': 66, 'type': 'enemy'},
      {'x': 70, 'type': 'platform', 'height': 3.5},
      {'x': 76, 'type': 'gap', 'width': 4},
      {'x': 84, 'type': 'platform', 'height': 2},
      {'x': 90, 'type': 'enemy'},
      {'x': 94, 'type': 'platform', 'height': 2.5},
      {'x': 100, 'type': 'coin_row', 'count': 5},
      {'x': 108, 'type': 'stair', 'steps': 5},
      {'x': 120, 'type': 'platform', 'height': 3},
      {'x': 126, 'type': 'enemy'},
      {'x': 130, 'type': 'gap', 'width': 6},
    ],
  );

  static const _level2 = LevelData(
    name: 'Dark Caverns',
    widthMultiplier: 10,
    layout: [
      {'x': 4, 'type': 'coin_row', 'count': 3},
      {'x': 8, 'type': 'gap', 'width': 5},
      {'x': 14, 'type': 'platform', 'height': 2},
      {'x': 18, 'type': 'enemy'},
      {'x': 20, 'type': 'enemy'},
      {'x': 24, 'type': 'gap', 'width': 4},
      {'x': 30, 'type': 'stair', 'steps': 3},
      {'x': 36, 'type': 'powerup_shield'},
      {'x': 40, 'type': 'enemy'},
      {'x': 42, 'type': 'enemy'},
      {'x': 46, 'type': 'platform', 'height': 3},
      {'x': 50, 'type': 'gap', 'width': 6},
      {'x': 58, 'type': 'platform', 'height': 2.5},
      {'x': 62, 'type': 'coin_row', 'count': 4},
      {'x': 68, 'type': 'enemy'},
      {'x': 72, 'type': 'stair', 'steps': 5},
      {'x': 80, 'type': 'platform', 'height': 4},
      {'x': 84, 'type': 'gap', 'width': 5},
      {'x': 90, 'type': 'powerup_speed'},
      {'x': 94, 'type': 'enemy'},
      {'x': 96, 'type': 'enemy'},
      {'x': 100, 'type': 'gap', 'width': 4},
      {'x': 106, 'type': 'platform', 'height': 2},
      {'x': 110, 'type': 'coin_row', 'count': 5},
      {'x': 118, 'type': 'stair', 'steps': 4},
      {'x': 126, 'type': 'enemy'},
      {'x': 130, 'type': 'platform', 'height': 3.5},
      {'x': 136, 'type': 'gap', 'width': 5},
      {'x': 144, 'type': 'enemy'},
      {'x': 148, 'type': 'platform', 'height': 2},
      {'x': 154, 'type': 'coin_row', 'count': 3},
    ],
  );

  static const _level3 = LevelData(
    name: 'Sky Fortress',
    widthMultiplier: 12,
    layout: [
      {'x': 3, 'type': 'powerup_shield'},
      {'x': 6, 'type': 'gap', 'width': 6},
      {'x': 14, 'type': 'enemy'},
      {'x': 16, 'type': 'enemy'},
      {'x': 18, 'type': 'platform', 'height': 2.5},
      {'x': 22, 'type': 'gap', 'width': 5},
      {'x': 28, 'type': 'stair', 'steps': 5},
      {'x': 36, 'type': 'coin_row', 'count': 4},
      {'x': 42, 'type': 'enemy'},
      {'x': 44, 'type': 'enemy'},
      {'x': 46, 'type': 'enemy'},
      {'x': 50, 'type': 'gap', 'width': 7},
      {'x': 58, 'type': 'platform', 'height': 3},
      {'x': 62, 'type': 'powerup_speed'},
      {'x': 66, 'type': 'gap', 'width': 5},
      {'x': 72, 'type': 'platform', 'height': 4},
      {'x': 76, 'type': 'enemy'},
      {'x': 78, 'type': 'enemy'},
      {'x': 82, 'type': 'stair', 'steps': 6},
      {'x': 92, 'type': 'coin_row', 'count': 5},
      {'x': 100, 'type': 'gap', 'width': 6},
      {'x': 108, 'type': 'platform', 'height': 2},
      {'x': 112, 'type': 'powerup_shield'},
      {'x': 116, 'type': 'enemy'},
      {'x': 118, 'type': 'enemy'},
      {'x': 120, 'type': 'enemy'},
      {'x': 124, 'type': 'gap', 'width': 5},
      {'x': 130, 'type': 'stair', 'steps': 4},
      {'x': 138, 'type': 'platform', 'height': 3.5},
      {'x': 142, 'type': 'gap', 'width': 7},
      {'x': 150, 'type': 'coin_row', 'count': 6},
      {'x': 160, 'type': 'enemy'},
      {'x': 162, 'type': 'enemy'},
      {'x': 166, 'type': 'platform', 'height': 4.5},
      {'x': 172, 'type': 'gap', 'width': 6},
      {'x': 180, 'type': 'powerup_speed'},
      {'x': 184, 'type': 'enemy'},
      {'x': 186, 'type': 'enemy'},
      {'x': 188, 'type': 'enemy'},
    ],
  );
}
