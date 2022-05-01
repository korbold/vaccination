import 'package:dartz/dartz.dart';
import 'package:vacunation_test_kruger/data/datasource/vaccination_remote.dart';
import 'package:vacunation_test_kruger/data/models/vaccination.dart';
import 'package:vacunation_test_kruger/domain/repositories/helpers/failure.dart';
import 'package:vacunation_test_kruger/domain/repositories/vaccination_repository.dart';

class VaccinationUseCase {
  final VaccinationRepository _vaccinationRepository;

  VaccinationUseCase(this._vaccinationRepository);

  Future<Either<Failure, void>> initVaccination() {
    return _vaccinationRepository.init();
  }

  Future<Either<Failure, VaccinationCreationResult>> createVaccination(
      Vaccination vaccination) {
    return _vaccinationRepository.createVaccination(vaccination);
  }

   Future<Either<Failure, List<Vaccination>>> getListVaccination(){
     return _vaccinationRepository.getListVaccination();
   }
}
