import 'package:get_it/get_it.dart';
import 'package:vacunation_test_kruger/data/datasource/data_remote.dart';
import 'package:vacunation_test_kruger/data/repositories/data_repositoryImpl.dart';
import 'package:vacunation_test_kruger/data/repositories/vaccination_repositoryImpl.dart';
import 'package:vacunation_test_kruger/domain/repositories/data_repository.dart';
import 'package:vacunation_test_kruger/domain/repositories/vaccination_repository.dart';
import 'package:vacunation_test_kruger/domain/usecases/dataUseCase.dart';
import 'package:vacunation_test_kruger/domain/usecases/vaccinationUseCase.dart';
import 'package:vacunation_test_kruger/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:vacunation_test_kruger/presentation/bloc/vaccination_bloc/vaccination_bloc.dart';

import 'data/datasource/vaccination_remote.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => FormBloc());
  locator.registerFactory(() => ChangeStateRadio('Empleado'));
  locator.registerFactory(() => UsersBloc(locator()));
  locator.registerFactory(() => VaccinationBloc(locator()));

  //  usecases
  locator.registerLazySingleton(() => DataUseCase(locator()));
  locator.registerLazySingleton(() => VaccinationUseCase(locator()));

  // repositories
  locator.registerLazySingleton<DataRepository>(
      () => DataRepositoryImpl(locator()));
  
  locator.registerLazySingleton<VaccinationRepository>(
      () => VaccinationRepositoryImpl(locator()));

  // data sources

  locator.registerLazySingleton<DataRemote>(() => DataRemoteImpl());
  locator
      .registerLazySingleton<VaccinationRemote>(() => VaccinationRemoteImpl());
}
