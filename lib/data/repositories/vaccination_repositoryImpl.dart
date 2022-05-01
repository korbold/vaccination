import 'package:vacunation_test_kruger/data/models/vaccination.dart';
import 'package:vacunation_test_kruger/data/datasource/vaccination_remote.dart';
import 'package:vacunation_test_kruger/domain/repositories/helpers/exception.dart';
import 'package:vacunation_test_kruger/domain/repositories/helpers/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:vacunation_test_kruger/domain/repositories/vaccination_repository.dart';

class VaccinationRepositoryImpl implements VaccinationRepository {
  final VaccinationRemote _vaccinationRepository;

  VaccinationRepositoryImpl(this._vaccinationRepository);
  @override
  Future<Either<Failure, void>> init() async {
    try {
      final result = await _vaccinationRepository.init();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error data InitUsers'));
    }
  }

  @override
  Future<Either<Failure, VaccinationCreationResult>> createVaccination(
      Vaccination vaccination) async {
    try {
      final result =
          await _vaccinationRepository.createVaccination(vaccination);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error data InitUsers'));
    }
  }

  @override
  Future<Either<Failure, List<Vaccination>>> getListVaccination() async {
    try {
      final result = await _vaccinationRepository.getListVaccination();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Error data InitUsers'));
    }
  }
}
