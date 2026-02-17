import '../../utils/constants.dart';

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
      {'x': 5, 'type': LevelItemType.gap, 'width': 4},
      {'x': 12, 'type': LevelItemType.platform, 'height': 2},
      {'x': 18, 'type': LevelItemType.enemy},
      {'x': 22, 'type': LevelItemType.platform, 'height': 2.5},
      {'x': 26, 'type': LevelItemType.coinRow, 'count': 3},
      {'x': 32, 'type': LevelItemType.platform, 'height': 3},
      {'x': 38, 'type': LevelItemType.enemy},
      {'x': 42, 'type': LevelItemType.gap, 'width': 5},
      {'x': 50, 'type': LevelItemType.platform, 'height': 2},
      {'x': 56, 'type': LevelItemType.stair, 'steps': 4},
      {'x': 66, 'type': LevelItemType.enemy},
      {'x': 70, 'type': LevelItemType.platform, 'height': 3.5},
      {'x': 76, 'type': LevelItemType.gap, 'width': 4},
      {'x': 84, 'type': LevelItemType.platform, 'height': 2},
      {'x': 90, 'type': LevelItemType.enemy},
      {'x': 94, 'type': LevelItemType.platform, 'height': 2.5},
      {'x': 100, 'type': LevelItemType.coinRow, 'count': 5},
      {'x': 108, 'type': LevelItemType.stair, 'steps': 5},
      {'x': 120, 'type': LevelItemType.platform, 'height': 3},
      {'x': 126, 'type': LevelItemType.enemy},
      {'x': 130, 'type': LevelItemType.gap, 'width': 6},
    ],
  );

  static const _level2 = LevelData(
    name: 'Dark Caverns',
    widthMultiplier: 10,
    layout: [
      {'x': 4, 'type': LevelItemType.coinRow, 'count': 3},
      {'x': 8, 'type': LevelItemType.gap, 'width': 5},
      {'x': 14, 'type': LevelItemType.platform, 'height': 2},
      {'x': 18, 'type': LevelItemType.enemy},
      {'x': 20, 'type': LevelItemType.enemy},
      {'x': 24, 'type': LevelItemType.gap, 'width': 4},
      {'x': 30, 'type': LevelItemType.stair, 'steps': 3},
      {'x': 36, 'type': LevelItemType.powerupShield},
      {'x': 40, 'type': LevelItemType.enemy},
      {'x': 42, 'type': LevelItemType.enemy},
      {'x': 46, 'type': LevelItemType.platform, 'height': 3},
      {'x': 50, 'type': LevelItemType.gap, 'width': 6},
      {'x': 58, 'type': LevelItemType.platform, 'height': 2.5},
      {'x': 62, 'type': LevelItemType.coinRow, 'count': 4},
      {'x': 68, 'type': LevelItemType.enemy},
      {'x': 72, 'type': LevelItemType.stair, 'steps': 5},
      {'x': 80, 'type': LevelItemType.platform, 'height': 4},
      {'x': 84, 'type': LevelItemType.gap, 'width': 5},
      {'x': 90, 'type': LevelItemType.powerupSpeed},
      {'x': 94, 'type': LevelItemType.enemy},
      {'x': 96, 'type': LevelItemType.enemy},
      {'x': 100, 'type': LevelItemType.gap, 'width': 4},
      {'x': 106, 'type': LevelItemType.platform, 'height': 2},
      {'x': 110, 'type': LevelItemType.coinRow, 'count': 5},
      {'x': 118, 'type': LevelItemType.stair, 'steps': 4},
      {'x': 126, 'type': LevelItemType.enemy},
      {'x': 130, 'type': LevelItemType.platform, 'height': 3.5},
      {'x': 136, 'type': LevelItemType.gap, 'width': 5},
      {'x': 144, 'type': LevelItemType.enemy},
      {'x': 148, 'type': LevelItemType.platform, 'height': 2},
      {'x': 154, 'type': LevelItemType.coinRow, 'count': 3},
    ],
  );

  static const _level3 = LevelData(
    name: 'Sky Fortress',
    widthMultiplier: 12,
    layout: [
      {'x': 3, 'type': LevelItemType.powerupShield},
      {'x': 6, 'type': LevelItemType.gap, 'width': 6},
      {'x': 14, 'type': LevelItemType.enemy},
      {'x': 16, 'type': LevelItemType.enemy},
      {'x': 18, 'type': LevelItemType.platform, 'height': 2.5},
      {'x': 22, 'type': LevelItemType.gap, 'width': 5},
      {'x': 28, 'type': LevelItemType.stair, 'steps': 5},
      {'x': 36, 'type': LevelItemType.coinRow, 'count': 4},
      {'x': 42, 'type': LevelItemType.enemy},
      {'x': 44, 'type': LevelItemType.enemy},
      {'x': 46, 'type': LevelItemType.enemy},
      {'x': 50, 'type': LevelItemType.gap, 'width': 7},
      {'x': 58, 'type': LevelItemType.platform, 'height': 3},
      {'x': 62, 'type': LevelItemType.powerupSpeed},
      {'x': 66, 'type': LevelItemType.gap, 'width': 5},
      {'x': 72, 'type': LevelItemType.platform, 'height': 4},
      {'x': 76, 'type': LevelItemType.enemy},
      {'x': 78, 'type': LevelItemType.enemy},
      {'x': 82, 'type': LevelItemType.stair, 'steps': 6},
      {'x': 92, 'type': LevelItemType.coinRow, 'count': 5},
      {'x': 100, 'type': LevelItemType.gap, 'width': 6},
      {'x': 108, 'type': LevelItemType.platform, 'height': 2},
      {'x': 112, 'type': LevelItemType.powerupShield},
      {'x': 116, 'type': LevelItemType.enemy},
      {'x': 118, 'type': LevelItemType.enemy},
      {'x': 120, 'type': LevelItemType.enemy},
      {'x': 124, 'type': LevelItemType.gap, 'width': 5},
      {'x': 130, 'type': LevelItemType.stair, 'steps': 4},
      {'x': 138, 'type': LevelItemType.platform, 'height': 3.5},
      {'x': 142, 'type': LevelItemType.gap, 'width': 7},
      {'x': 150, 'type': LevelItemType.coinRow, 'count': 6},
      {'x': 160, 'type': LevelItemType.enemy},
      {'x': 162, 'type': LevelItemType.enemy},
      {'x': 166, 'type': LevelItemType.platform, 'height': 4.5},
      {'x': 172, 'type': LevelItemType.gap, 'width': 6},
      {'x': 180, 'type': LevelItemType.powerupSpeed},
      {'x': 184, 'type': LevelItemType.enemy},
      {'x': 186, 'type': LevelItemType.enemy},
      {'x': 188, 'type': LevelItemType.enemy},
    ],
  );
}
