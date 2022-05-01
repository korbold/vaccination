import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:formz/formz.dart';
import 'package:vacunation_test_kruger/data/datasource/data_remote.dart';
import 'package:vacunation_test_kruger/data/models/email.dart';
import 'package:vacunation_test_kruger/data/models/password.dart';
import 'package:vacunation_test_kruger/data/models/users.dart';
import 'package:vacunation_test_kruger/domain/usecases/dataUseCase.dart';
part 'user_event.dart';
part 'user_state.dart';

class UsersBloc extends Bloc<UserEvent, UserState> {
  final DataUseCase _dataUseCase;

  UsersBloc(this._dataUseCase) : super(UserInitialState()) {
    on<UserInitialData>(initdata);

    on<UserCreate>((event, emit) async {
      final result = await _dataUseCase.createUser(event.users);

      result.fold((l) => null, (r) {
        switch (r) {
          case UserCreationResult.success:
            emit(UserHasData(user: event.users));
            break;
          case UserCreationResult.alreadyExists:
            emit(UserExistState());
            break;
          default:
        }
      });
    });

    on<DeleteUser>((event, emit) async {
      final result = await _dataUseCase.deleteUser(event.ci);

      result.fold((l) => null, (r) {
        emit(DeleteState());
      });
    });

    on<ListUsersEvent>((event, emit) async {
      final result = await _dataUseCase.getListUsers();

      result.fold((l) => null, (r) {
        emit(ListUsersState(users: r));
      });
    });
    on<GetListUserEvent>((event, emit) async {
      final result = await _dataUseCase.getUser(event.ci);

      result.fold((l) => null, (r) {
        emit(GetUserById(user: r[0]));
      });
    });

    on<PutUserEvent>((event, emit) async {
      final result = await _dataUseCase.putUser(event.user);

      result.fold((l) => null, (r) {
        emit(UserUpdate());
      });
    });
    on<LoginEvent>((event, emit) async {
      final result = await _dataUseCase.login(event.user, event.password);

      result.fold((l) => null, (r) {
        switch (r) {
          case UserCreationResult.alreadyExists:
            emit(UserFound());
            break;
          case UserCreationResult.failure:
            emit(UserNotFound());
            break;
          default:
        }
      });
    });
  }

  void initdata(event, emit) async {
    await _dataUseCase.initUser();

    emit(UserInitialState());
  }
}

class ChangeStateRadio extends Bloc<UserEvent, String> {
  ChangeStateRadio(String initialState) : super('Empleado') {
    on<ChangeRoleEvent>((event, emit) async {
      emit((event.role));
    });
  }
}

class FormBloc extends Bloc<FormEvent, FormStateValid> {
  FormBloc() : super(FormStateValid()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  @override
  void onTransition(Transition<FormEvent, FormStateValid> transition) {
    super.onTransition(transition);
  }

  void _onEmailChanged(EmailChanged event, Emitter<FormStateValid> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.valid ? email : Email.pure(event.email),
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<FormStateValid> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password.valid ? password : Password.pure(event.password),
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<FormStateValid> emit) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordUnfocused(
    PasswordUnfocused event,
    Emitter<FormStateValid> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<FormStateValid> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    ));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
