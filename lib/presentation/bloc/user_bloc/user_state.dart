part of 'user_bloc.dart';

abstract class UserState extends Equatable {}

class UserLogoutValidState extends UserState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserInitialState extends UserState {
  UserInitialState();

  @override
  List<Object?> get props => [];
}

class UserUpdate extends UserState {
  UserUpdate();

  @override
  List<Object?> get props => [];
}

class ListUsersState extends UserState {
  final List<Users>? users;
  ListUsersState({this.users});

  @override
  List<Object> get props => [users!];
}

class GetUserById extends UserState {
  final Users? user;
  GetUserById({this.user});

  @override
  List<Object> get props => [user!];
}

class UserExistState extends UserState {
  UserExistState();

  @override
  List<Object> get props => [];
}

class DeleteState extends UserState {
  DeleteState();

  @override
  List<Object> get props => [];
}

class UserHasData extends UserState {
  final Users? user;
  UserHasData({this.user});

  @override
  List<Object> get props => [user!];
}

class ChangeRoleState extends UserState {
  final String role;

  ChangeRoleState(this.role);
  @override
  List<Object?> get props => [role];
}

class UserNotFound extends UserState {
  @override

  List<Object?> get props => throw UnimplementedError();
}
class UserFound extends UserState {
  @override

  List<Object?> get props => throw UnimplementedError();
}

class FormStateValid extends UserState {
  FormStateValid({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final FormzStatus status;

  FormStateValid copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return FormStateValid(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
