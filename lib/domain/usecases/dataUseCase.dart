import 'package:dartz/dartz.dart';
import 'package:vacunation_test_kruger/data/datasource/data_remote.dart';
import 'package:vacunation_test_kruger/data/models/users.dart';

import 'package:vacunation_test_kruger/domain/repositories/data_repository.dart';
import 'package:vacunation_test_kruger/domain/repositories/vaccination_repository.dart';

import '../repositories/helpers/failure.dart';

class DataUseCase {
  final DataRepository _dataRepository;
 

  DataUseCase(this._dataRepository);

  Future<Either<Failure, void>> initUser() {
    return _dataRepository.init();
  }

  Future<Either<Failure, void>> deleteUser(String ci) {
    return _dataRepository.deleteUser(ci);
  }

  Future<Either<Failure, UserCreationResult>> createUser(Users user) {
    return _dataRepository.createUser(user);
  }

  Future<Either<Failure, UserCreationResult>> login(String user, String password) {
    return _dataRepository.login(user,password);
  }

  Future<Either<Failure, List<Users>>> getListUsers() async {
    return await _dataRepository.getListUsers();
  }

  Future<Either<Failure, List<Users>>> getUser(String ci) async {
    return await _dataRepository.getUser(ci);
  }

  Future<Either<Failure, void>> putUser(Users user) {
    return _dataRepository.putUser(user);
  }

 

}
