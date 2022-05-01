part of 'vaccination_bloc.dart';

abstract class VaccinationEvent extends Equatable {
  const VaccinationEvent();
}

class VaccinationInitialEvent extends VaccinationEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateVaccinationEvent extends VaccinationEvent {
  final Vaccination vaccination;

  const CreateVaccinationEvent(this.vaccination);
  @override
  List<Object?> get props => [vaccination];
}

class GetListVaccionation extends VaccinationEvent {
  @override

  List<Object?> get props => throw UnimplementedError();
  
}
