import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vacunation_test_kruger/data/datasource/vaccination_remote.dart';
import 'package:vacunation_test_kruger/data/models/vaccination.dart';
import 'package:vacunation_test_kruger/domain/usecases/vaccinationUseCase.dart';

part 'vaccination_event.dart';
part 'vaccination_state.dart';

class VaccinationBloc extends Bloc<VaccinationEvent, VaccinationState> {
  final VaccinationUseCase _useCase;
  VaccinationBloc(this._useCase) : super(VaccinationInitial()) {
    on<VaccinationInitialEvent>(initdata);
    on<CreateVaccinationEvent>((event, emit) async {
      final result = await _useCase.createVaccination(event.vaccination);
      result.fold((l) => null, (r) {
        switch (r) {
          case VaccinationCreationResult.success:
            emit(CreateVaccinationSate(event.vaccination));
            break;

          default:
        }
      });
    });
    on<GetListVaccionation>((event, emit) async {
      final result = await _useCase.getListVaccination();
      result.fold((l) => null, (r) {
        emit(GetListVaccionationState(r));
      });
    });
  }
  void initdata(event, emit) async {
    await _useCase.initVaccination();

    emit(VaccinationInitialState());
  }
}
