part of 'vaccination_bloc.dart';

abstract class VaccinationState extends Equatable {
  const VaccinationState();
}

class VaccinationInitial extends VaccinationState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class VaccinationInitialState extends VaccinationState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateVaccinationSate extends VaccinationState {
  final Vaccination vaccination;

  const CreateVaccinationSate(this.vaccination);
  @override
  List<Object?> get props => [vaccination];
}

class GetListVaccionationState extends VaccinationState {
  final List< Vaccination> vaccination;

  const GetListVaccionationState(this.vaccination);
  @override
  List<Object?> get props => [vaccination];
}
