import 'package:hive/hive.dart';

part 'users.g.dart';

@HiveType(typeId: 1)
class Users  extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String ci;
  @HiveField(2)
  final String surname;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String password;
  @HiveField(5)
  final String dateBirthdays;
  @HiveField(6)
  final String addressHome;
  @HiveField(7)
  final String phoneNumber;
  @HiveField(8)
  final String role;

  Users(
    this.name,
    this.ci,
    this.surname,
    this.email,
    this.role,
    this.dateBirthdays,
    this.addressHome,
    this.phoneNumber,
    this.password,
  );
}
