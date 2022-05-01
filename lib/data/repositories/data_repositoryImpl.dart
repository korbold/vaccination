import 'package:vacunation_test_kruger/data/datasource/data_remote.dart';
import 'package:vacunation_test_kruger/data/models/users.dart';


import 'package:dartz/dartz.dart';
import 'package:vacunation_test_kruger/domain/repositories/data_repository.dart';

import '../../domain/repositories/helpers/exception.dart';
import '../../domain/repositories/helpers/failure.dart';

class DataRepositoryImpl implements DataRepository {
  final DataRemote dataRemote;

  DataRepositoryImpl(this.dataRemote);
  @override
  Future<Either<Failure, void>> init() async {
    try {
      final result = await dataRemote.init();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error data InitUsers'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String ci) async {
    try {
      final result = await dataRemote.deleteUser(ci);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error data delete'));
    }
  }

  @override
  Future<Either<Failure, UserCreationResult>> createUser(Users users) async {
    try {
      final result = await dataRemote.createUser(users);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error create Users'));
    }
  }

    @override
  Future<Either<Failure, UserCreationResult>> login(String user, String password) async {
    try {
      final result = await dataRemote.login(user,password);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error create Users'));
    }
  }

  @override
  Future<Either<Failure, List<Users>>> getListUsers() async {
    try {
      final result = await dataRemote.getListUsers();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error data List Users'));
    }
  }

  @override
  Future<Either<Failure, List<Users>>> getUser(String ci) async {
    try {
      final result = await dataRemote.getUser(ci);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error data List Users'));
    }
  }

  @override
  Future<Either<Failure, void>> putUser(Users user) async {
    try {
      final result = await dataRemote.putUser(user);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error data List Users'));
    }
  }
}
