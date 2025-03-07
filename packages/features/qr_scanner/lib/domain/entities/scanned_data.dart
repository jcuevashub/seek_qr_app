import 'package:hive/hive.dart';

part 'scanned_data.g.dart';

@HiveType(typeId: 0)
class ScannedData {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final DateTime timestamp;

  ScannedData({required this.content, required this.timestamp});
}
