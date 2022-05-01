import 'package:dartz/dartz.dart';
import 'package:vacunation_test_kruger/data/datasource/data_remote.dart';
import 'package:vacunation_test_kruger/data/models/users.dart';


import 'helpers/failure.dart';

abstract class DataRepository {
  Future<Either<Failure, void>> init();
  Future<Either<Failure, void>> deleteUser(String ci);
  Future<Either<Failure, void>> putUser(Users user);
  Future<Either<Failure, UserCreationResult>> createUser(Users users);
  Future<Either<Failure, UserCreationResult>> login(String user, String password);
  Future<Either<Failure, List<Users>>> getListUsers();
  Future<Either<Failure, List<Users>>> getUser(String ci);
}
