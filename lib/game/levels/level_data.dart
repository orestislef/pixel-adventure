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

  static const _level1 = LevelData(
    name: 'Green Hills',
    widthMultiplier: 8,
    layout: [
      LevelItem(x: 5, type: LevelItemType.gap, width: 4),
      LevelItem(x: 12, type: LevelItemType.platform, height: 2),
      LevelItem(x: 18, type: LevelItemType.enemy),
      LevelItem(x: 22, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 26, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 32, type: LevelItemType.platform, height: 3),
      LevelItem(x: 38, type: LevelItemType.enemy),
      LevelItem(x: 42, type: LevelItemType.gap, width: 5),
      LevelItem(x: 50, type: LevelItemType.platform, height: 2),
      LevelItem(x: 56, type: LevelItemType.stair, steps: 4),
      LevelItem(x: 66, type: LevelItemType.enemy),
      LevelItem(x: 70, type: LevelItemType.platform, height: 3.5),
      LevelItem(x: 76, type: LevelItemType.gap, width: 4),
      LevelItem(x: 84, type: LevelItemType.platform, height: 2),
      LevelItem(x: 90, type: LevelItemType.enemy),
      LevelItem(x: 94, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 100, type: LevelItemType.coinRow, count: 5),
      LevelItem(x: 108, type: LevelItemType.stair, steps: 5),
      LevelItem(x: 120, type: LevelItemType.platform, height: 3),
      LevelItem(x: 126, type: LevelItemType.enemy),
      LevelItem(x: 130, type: LevelItemType.gap, width: 6),
    ],
  );

  static const _level2 = LevelData(
    name: 'Dark Caverns',
    widthMultiplier: 10,
    layout: [
      LevelItem(x: 4, type: LevelItemType.coinRow, count: 3),
      LevelItem(x: 8, type: LevelItemType.gap, width: 5),
      LevelItem(x: 14, type: LevelItemType.platform, height: 2),
      LevelItem(x: 18, type: LevelItemType.enemy),
      LevelItem(x: 20, type: LevelItemType.enemy),
      LevelItem(x: 24, type: LevelItemType.gap, width: 4),
      LevelItem(x: 30, type: LevelItemType.stair, steps: 3),
      LevelItem(x: 36, type: LevelItemType.powerupShield),
      LevelItem(x: 40, type: LevelItemType.enemy),
      LevelItem(x: 42, type: LevelItemType.enemy),
      LevelItem(x: 46, type: LevelItemType.platform, height: 3),
      LevelItem(x: 50, type: LevelItemType.gap, width: 6),
      LevelItem(x: 58, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 62, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 68, type: LevelItemType.enemy),
      LevelItem(x: 72, type: LevelItemType.stair, steps: 5),
      LevelItem(x: 80, type: LevelItemType.platform, height: 4),
      LevelItem(x: 84, type: LevelItemType.gap, width: 5),
      LevelItem(x: 90, type: LevelItemType.powerupSpeed),
      LevelItem(x: 94, type: LevelItemType.enemy),
      LevelItem(x: 96, type: LevelItemType.enemy),
      LevelItem(x: 100, type: LevelItemType.gap, width: 4),
      LevelItem(x: 106, type: LevelItemType.platform, height: 2),
      LevelItem(x: 110, type: LevelItemType.coinRow, count: 5),
      LevelItem(x: 118, type: LevelItemType.stair, steps: 4),
      LevelItem(x: 126, type: LevelItemType.enemy),
      LevelItem(x: 130, type: LevelItemType.platform, height: 3.5),
      LevelItem(x: 136, type: LevelItemType.gap, width: 5),
      LevelItem(x: 144, type: LevelItemType.enemy),
      LevelItem(x: 148, type: LevelItemType.platform, height: 2),
      LevelItem(x: 154, type: LevelItemType.coinRow, count: 3),
    ],
  );

  static const _level3 = LevelData(
    name: 'Sky Fortress',
    widthMultiplier: 12,
    layout: [
      LevelItem(x: 3, type: LevelItemType.powerupShield),
      LevelItem(x: 6, type: LevelItemType.gap, width: 6),
      LevelItem(x: 14, type: LevelItemType.enemy),
      LevelItem(x: 16, type: LevelItemType.enemy),
      LevelItem(x: 18, type: LevelItemType.platform, height: 2.5),
      LevelItem(x: 22, type: LevelItemType.gap, width: 5),
      LevelItem(x: 28, type: LevelItemType.stair, steps: 5),
      LevelItem(x: 36, type: LevelItemType.coinRow, count: 4),
      LevelItem(x: 42, type: LevelItemType.enemy),
      LevelItem(x: 44, type: LevelItemType.enemy),
      LevelItem(x: 46, type: LevelItemType.enemy),
      LevelItem(x: 50, type: LevelItemType.gap, width: 7),
      LevelItem(x: 58, type: LevelItemType.platform, height: 3),
      LevelItem(x: 62, type: LevelItemType.powerupSpeed),
      LevelItem(x: 66, type: LevelItemType.gap, width: 5),
      LevelItem(x: 72, type: LevelItemType.platform, height: 4),
      LevelItem(x: 76, type: LevelItemType.enemy),
      LevelItem(x: 78, type: LevelItemType.enemy),
      LevelItem(x: 82, type: LevelItemType.stair, steps: 6),
      LevelItem(x: 92, type: LevelItemType.coinRow, count: 5),
      LevelItem(x: 100, type: LevelItemType.gap, width: 6),
      LevelItem(x: 108, type: LevelItemType.platform, height: 2),
      LevelItem(x: 112, type: LevelItemType.powerupShield),
      LevelItem(x: 116, type: LevelItemType.enemy),
      LevelItem(x: 118, type: LevelItemType.enemy),
      LevelItem(x: 120, type: LevelItemType.enemy),
      LevelItem(x: 124, type: LevelItemType.gap, width: 5),
      LevelItem(x: 130, type: LevelItemType.stair, steps: 4),
      LevelItem(x: 138, type: LevelItemType.platform, height: 3.5),
      LevelItem(x: 142, type: LevelItemType.gap, width: 7),
      LevelItem(x: 150, type: LevelItemType.coinRow, count: 6),
      LevelItem(x: 160, type: LevelItemType.enemy),
      LevelItem(x: 162, type: LevelItemType.enemy),
      LevelItem(x: 166, type: LevelItemType.platform, height: 4.5),
      LevelItem(x: 172, type: LevelItemType.gap, width: 6),
      LevelItem(x: 180, type: LevelItemType.powerupSpeed),
      LevelItem(x: 184, type: LevelItemType.enemy),
      LevelItem(x: 186, type: LevelItemType.enemy),
      LevelItem(x: 188, type: LevelItemType.enemy),
    ],
  );
}
