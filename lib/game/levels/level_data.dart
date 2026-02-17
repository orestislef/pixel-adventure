import '../../utils/constants.dart';

class LevelItem {
  final num x;
  final LevelItemType type;
  final num? height;
  final num? width;
  final int? count;
  final int? steps;

  const LevelItem({
    required this.x,
    required this.type,
    this.height,
    this.width,
    this.count,
    this.steps,
  });
}

class LevelData {
  final String name;
  final double widthMultiplier;
  final List<LevelItem> layout;

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

  // Level 1: Easy intro — gentle gaps, few enemies, lots of coins
  static const _level1 = LevelData(
    name: 'Green Hills',
    widthMultiplier: 5,
    layout: [
      LevelItem(x: 6, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 12, type: LevelItemType.platform, height: 2),
      LevelItem(x: 18, type: LevelItemType.enemy),
      LevelItem(x: 22, type: LevelItemType.gap, width: 3),
      LevelItem(x: 27, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 32, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 38, type: LevelItemType.enemy),
      LevelItem(x: 42, type: LevelItemType.platform, height: 2),
      LevelItem(x: 48, type: LevelItemType.gap, width: 4),
      LevelItem(x: 54, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 62, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 68, type: LevelItemType.enemy),
      LevelItem(x: 72, type: LevelItemType.platform, height: 3),
      LevelItem(x: 78, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 84, type: LevelItemType.gap, width: 3),
      LevelItem(x: 89, type: LevelItemType.platform, height: 2),
      LevelItem(x: 94, type: LevelItemType.enemy),
      LevelItem(x: 98, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 106, type: LevelItemType.coinRow, count: 5),
      LevelItem(x: 114, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 120, type: LevelItemType.enemy),
      LevelItem(x: 124, type: LevelItemType.coinRow, count: 3),
    ],
  );

  // Level 2: Medium — more enemies, wider gaps, power-ups introduced
  static const _level2 = LevelData(
    name: 'Dark Caverns',
    widthMultiplier: 6,
    layout: [
      LevelItem(x: 4, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 8, type: LevelItemType.enemy),
      LevelItem(x: 12, type: LevelItemType.gap, width: 4),
      LevelItem(x: 18, type: LevelItemType.platform, height: 2),
      LevelItem(x: 22, type: LevelItemType.enemy),
      LevelItem(x: 24, type: LevelItemType.enemy),
      LevelItem(x: 28, type: LevelItemType.powerupShield),
      LevelItem(x: 32, type: LevelItemType.gap, width: 4),
      LevelItem(x: 38, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 44, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 50, type: LevelItemType.platform, height: 3),
      LevelItem(x: 54, type: LevelItemType.enemy),
      LevelItem(x: 56, type: LevelItemType.enemy),
      LevelItem(x: 60, type: LevelItemType.gap, width: 5),
      LevelItem(x: 67, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 72, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 78, type: LevelItemType.stair, steps: 4),
      LevelItem(x: 86, type: LevelItemType.enemy),
      LevelItem(x: 90, type: LevelItemType.powerupSpeed),
      LevelItem(x: 94, type: LevelItemType.gap, width: 4),
      LevelItem(x: 100, type: LevelItemType.platform, height: 2),
      LevelItem(x: 104, type: LevelItemType.enemy),
      LevelItem(x: 106, type: LevelItemType.enemy),
      LevelItem(x: 110, type: LevelItemType.coinRow, count: 5),
      LevelItem(x: 118, type: LevelItemType.platform, height: 3.5),
      LevelItem(x: 124, type: LevelItemType.gap, width: 4),
      LevelItem(x: 130, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 136, type: LevelItemType.enemy),
      LevelItem(x: 140, type: LevelItemType.platform, height: 2),
      LevelItem(x: 146, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 152, type: LevelItemType.enemy),
    ],
  );

  // Level 3: Hard — triple enemies, wide gaps, both power-ups needed
  static const _level3 = LevelData(
    name: 'Sky Fortress',
    widthMultiplier: 8,
    layout: [
      LevelItem(x: 3, type: LevelItemType.powerupShield),
      LevelItem(x: 6, type: LevelItemType.enemy),
      LevelItem(x: 8, type: LevelItemType.enemy),
      LevelItem(x: 12, type: LevelItemType.gap, width: 5),
      LevelItem(x: 19, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 24, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 30, type: LevelItemType.enemy),
      LevelItem(x: 32, type: LevelItemType.enemy),
      LevelItem(x: 34, type: LevelItemType.enemy),
      LevelItem(x: 38, type: LevelItemType.gap, width: 5),
      LevelItem(x: 45, type: LevelItemType.stair, steps: 4),
      LevelItem(x: 53, type: LevelItemType.platform, height: 3),
      LevelItem(x: 58, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 64, type: LevelItemType.powerupSpeed),
      LevelItem(x: 68, type: LevelItemType.enemy),
      LevelItem(x: 70, type: LevelItemType.enemy),
      LevelItem(x: 74, type: LevelItemType.gap, width: 5),
      LevelItem(x: 81, type: LevelItemType.platform, height: 4),
      LevelItem(x: 86, type: LevelItemType.stair, steps: 5),
      LevelItem(x: 96, type: LevelItemType.coinRow, count: 5),
      LevelItem(x: 104, type: LevelItemType.enemy),
      LevelItem(x: 106, type: LevelItemType.enemy),
      LevelItem(x: 108, type: LevelItemType.enemy),
      LevelItem(x: 112, type: LevelItemType.gap, width: 6),
      LevelItem(x: 120, type: LevelItemType.powerupShield),
      LevelItem(x: 124, type: LevelItemType.platform, height: 2),
      LevelItem(x: 128, type: LevelItemType.enemy),
      LevelItem(x: 130, type: LevelItemType.enemy),
      LevelItem(x: 134, type: LevelItemType.stair, steps: 4),
      LevelItem(x: 142, type: LevelItemType.coinRow, count: 5),
      LevelItem(x: 150, type: LevelItemType.gap, width: 6),
      LevelItem(x: 158, type: LevelItemType.platform, height: 3.5),
      LevelItem(x: 162, type: LevelItemType.powerupSpeed),
      LevelItem(x: 166, type: LevelItemType.enemy),
      LevelItem(x: 168, type: LevelItemType.enemy),
      LevelItem(x: 170, type: LevelItemType.enemy),
      LevelItem(x: 174, type: LevelItemType.platform, height: 4),
      LevelItem(x: 180, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 186, type: LevelItemType.gap, width: 5),
      LevelItem(x: 193, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 200, type: LevelItemType.enemy),
      LevelItem(x: 202, type: LevelItemType.enemy),
      LevelItem(x: 206, type: LevelItemType.coinRow, count: 3),
    ],
  );
}
