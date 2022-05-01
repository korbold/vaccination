import 'package:hive/hive.dart';
import 'package:vacunation_test_kruger/data/models/users.dart';

import 'package:random_password_generator/random_password_generator.dart';

import '../models/vaccination.dart';

abstract class DataRemote {
  Future<void> init();
  Future<String?> authenticateUser(final String email, final String password);
  Future<UserCreationResult> createUser(Users users);
  Future<List<Users>> getListUsers();
  Future<void> deleteUser(String ci);
  Future<List<Users>> getUser(String ci);
  Future<void> putUser(Users user);
  Future<UserCreationResult> login(String user, String password);
}

class DataRemoteImpl implements DataRemote {
  final password = RandomPasswordGenerator();

  late Box<Users> _users;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UsersAdapter());
    }
    _users = await Hive.openBox<Users>('users');

  }

  @override
  Future<String?> authenticateUser(
      final String email, final String password) async {
    final success = _users.values.any(
        (element) => element.email == email && element.password == password);
    if (success) {
      return email;
    } else {
      return null;
    }
  }

  @override
  Future<UserCreationResult> createUser(Users users) async {
    final alreadyExists = _users.values.any(
      (element) => element.ci.toLowerCase() == users.ci.toLowerCase(),
    );

    if (alreadyExists) {
      return UserCreationResult.alreadyExists;
    }

    try {
      String newPassword = password.randomPassword(
          letters: true,
          numbers: true,
          specialChar: true,
          uppercase: false,
          passwordLength: 12);

      _users.add(Users(users.name, users.ci, users.surname, users.email,
          users.role,'', '', '', newPassword));

      return UserCreationResult.success;
    } on Exception catch (ex) {
      return UserCreationResult.failure;
    }
  }

  @override
  Future<List<Users>> getListUsers() async {
    _users = await Hive.openBox<Users>('users');
    return _users.values.toList();
  }

  @override
  Future<void> deleteUser(String ci) async {
    _users = await Hive.openBox<Users>('users');
    final result = _users.values.firstWhere((element) => element.ci == ci);
    await result.delete();
  }

  @override
  Future<List<Users>> getUser(String ci) async {
    _users = await Hive.openBox<Users>('users');
    final result = _users.values.where((element) => element.ci == ci);
    return result.toList();
  }

  @override
  Future<void> putUser(Users user) async {
    _users = await Hive.openBox<Users>('users');

    final result = _users.values.firstWhere((element) => element.ci == user.ci);
    final index = result.key as int;

    await _users.put(index, user);
  }

  @override
  Future<UserCreationResult> login(String user, String password) async {
    final alreadyExists = _users.values.any(
      (element) =>
          element.ci.toLowerCase() == user.toLowerCase() &&
          element.password.toLowerCase() == password.toLowerCase(),
    );

    if (alreadyExists) {
      return UserCreationResult.alreadyExists;
    } else {
      return UserCreationResult.failure;
    }
  }
}

enum UserCreationResult { success, failure, alreadyExists }
