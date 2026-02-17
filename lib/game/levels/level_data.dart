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

  // Level 1: Easy intro — safe start, gentle gaps, few enemies
  // Flag at ~112 tiles min (16:9). Items end by x:100.
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
      LevelItem(x: 48, type: LevelItemType.gap, width: 3),
      LevelItem(x: 53, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 60, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 66, type: LevelItemType.enemy),
      LevelItem(x: 70, type: LevelItemType.platform, height: 3),
      LevelItem(x: 76, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 82, type: LevelItemType.gap, width: 3),
      LevelItem(x: 87, type: LevelItemType.platform, height: 2),
      LevelItem(x: 93, type: LevelItemType.enemy),
      LevelItem(x: 97, type: LevelItemType.coinRow, count: 3),
    ],
  );

  // Level 2: Medium — double enemies, wider gaps, power-ups introduced
  // Flag at ~135 tiles min (16:9). Items end by x:123.
  static const _level2 = LevelData(
    name: 'Dark Caverns',
    widthMultiplier: 6,
    layout: [
      LevelItem(x: 6, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 12, type: LevelItemType.platform, height: 2),
      LevelItem(x: 18, type: LevelItemType.enemy),
      LevelItem(x: 22, type: LevelItemType.enemy),
      LevelItem(x: 26, type: LevelItemType.powerupShield),
      LevelItem(x: 30, type: LevelItemType.gap, width: 4),
      LevelItem(x: 36, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 43, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 50, type: LevelItemType.platform, height: 3),
      LevelItem(x: 55, type: LevelItemType.enemy),
      LevelItem(x: 57, type: LevelItemType.enemy),
      LevelItem(x: 62, type: LevelItemType.gap, width: 5),
      LevelItem(x: 69, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 75, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 82, type: LevelItemType.enemy),
      LevelItem(x: 86, type: LevelItemType.stair, steps: 4),
      LevelItem(x: 95, type: LevelItemType.powerupSpeed),
      LevelItem(x: 99, type: LevelItemType.gap, width: 4),
      LevelItem(x: 105, type: LevelItemType.platform, height: 2),
      LevelItem(x: 111, type: LevelItemType.enemy),
      LevelItem(x: 113, type: LevelItemType.enemy),
      LevelItem(x: 117, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 123, type: LevelItemType.enemy),
    ],
  );

  // Level 3: Hard — triple enemies, wide gaps, both power-ups needed
  // Flag at ~182 tiles min (16:9). Items end by x:168.
  static const _level3 = LevelData(
    name: 'Sky Fortress',
    widthMultiplier: 8,
    layout: [
      LevelItem(x: 5, type: LevelItemType.powerupShield),
      LevelItem(x: 8, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 16, type: LevelItemType.enemy),
      LevelItem(x: 18, type: LevelItemType.enemy),
      LevelItem(x: 22, type: LevelItemType.gap, width: 5),
      LevelItem(x: 29, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 35, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 42, type: LevelItemType.enemy),
      LevelItem(x: 44, type: LevelItemType.enemy),
      LevelItem(x: 46, type: LevelItemType.enemy),
      LevelItem(x: 50, type: LevelItemType.gap, width: 5),
      LevelItem(x: 57, type: LevelItemType.stair, steps: 4),
      LevelItem(x: 66, type: LevelItemType.platform, height: 3),
      LevelItem(x: 72, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 78, type: LevelItemType.powerupSpeed),
      LevelItem(x: 82, type: LevelItemType.enemy),
      LevelItem(x: 84, type: LevelItemType.enemy),
      LevelItem(x: 88, type: LevelItemType.gap, width: 5),
      LevelItem(x: 95, type: LevelItemType.platform, height: 4),
      LevelItem(x: 102, type: LevelItemType.stair, steps: 5),
      LevelItem(x: 113, type: LevelItemType.coinRow, count: 5),
      LevelItem(x: 120, type: LevelItemType.enemy),
      LevelItem(x: 122, type: LevelItemType.enemy),
      LevelItem(x: 124, type: LevelItemType.enemy),
      LevelItem(x: 128, type: LevelItemType.gap, width: 6),
      LevelItem(x: 136, type: LevelItemType.powerupShield),
      LevelItem(x: 140, type: LevelItemType.platform, height: 2),
      LevelItem(x: 146, type: LevelItemType.enemy),
      LevelItem(x: 148, type: LevelItemType.enemy),
      LevelItem(x: 152, type: LevelItemType.powerupSpeed),
      LevelItem(x: 155, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 163, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 168, type: LevelItemType.enemy),
    ],
  );
}
