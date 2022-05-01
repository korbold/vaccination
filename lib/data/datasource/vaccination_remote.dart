import 'package:hive/hive.dart';
import 'package:vacunation_test_kruger/data/models/vaccination.dart';

abstract class VaccinationRemote {
  Future<void> init();
  Future<VaccinationCreationResult> createVaccination(Vaccination vaccination);
  Future<List<Vaccination>> getListVaccination();
}

class VaccinationRemoteImpl implements VaccinationRemote {
  late Box<Vaccination> _vaccination;
  @override
  Future<void> init() async {
    Hive.registerAdapter(VaccinationAdapter());

    _vaccination = await Hive.openBox<Vaccination>('vaccination');
  }

  @override
  Future<VaccinationCreationResult> createVaccination(
      Vaccination vaccination) async {
    _vaccination = await Hive.openBox<Vaccination>('vaccination');
    try {
      _vaccination.add(Vaccination(vaccination.userId, vaccination.type,
          vaccination.date, vaccination.numberDoses));

      return VaccinationCreationResult.success;
    } on Exception catch (ex) {
      return VaccinationCreationResult.failure;
    }
  }

  @override
  Future<List<Vaccination>> getListVaccination() async {
    _vaccination = await Hive.openBox<Vaccination>('vaccination');
    return _vaccination.values.toList();
  }
}

enum VaccinationCreationResult { success, failure, alreadyExists }
