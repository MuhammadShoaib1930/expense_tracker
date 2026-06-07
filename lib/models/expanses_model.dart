import 'package:hive_flutter/hive_flutter.dart';

part 'expanses_model.g.dart';

@HiveType(typeId: 0)
class ExpansesModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double prices;
  @HiveField(3)
  final DateTime dateTime;
  @HiveField(4)
  final int updated;
  @HiveField(5)
  final bool isDone;
  ExpansesModel({
    String? id,
    required this.title,
    required this.prices,
    required this.dateTime,
    this.updated = 0,
    this.isDone = false,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();

  ExpansesModel copyWith({
    String? title,
    double? prices,
    DateTime? dateTime,
    int? updated,
    bool? isDone,
    String? id,
  }) {
    return ExpansesModel(
      title: title ?? this.title,
      prices: prices ?? this.prices,
      dateTime: dateTime ?? this.dateTime,
      isDone: isDone ?? this.isDone,
      updated: updated ?? this.updated,
      id: id ?? this.id,
    );
  }
}
