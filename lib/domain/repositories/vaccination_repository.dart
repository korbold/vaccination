import 'package:dartz/dartz.dart';
import 'package:vacunation_test_kruger/data/models/vaccination.dart';
import 'package:vacunation_test_kruger/domain/repositories/helpers/failure.dart';

import '../../data/datasource/vaccination_remote.dart';

abstract class VaccinationRepository {
  Future<Either<Failure, void>> init();
  Future<Either<Failure, VaccinationCreationResult>> createVaccination(
      Vaccination vaccination);
      Future<Either<Failure, List<Vaccination>>> getListVaccination();
}
