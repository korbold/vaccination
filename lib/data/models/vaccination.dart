import 'package:hive/hive.dart';

part 'vaccination.g.dart';

@HiveType(typeId: 2)
class Vaccination  extends HiveObject {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String type;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final int numberDoses;

  Vaccination(this.userId, this.type, this.date, this.numberDoses);
}
