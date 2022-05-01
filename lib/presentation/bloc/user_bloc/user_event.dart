part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoginEvent extends UserEvent {
  final String user, password;

  const LoginEvent(this.user, this.password);

  @override
  List<Object> get props => [user, password];
}

class UserCurrentEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ListUsersEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class GetListUserEvent extends UserEvent {
  final String ci;

  GetListUserEvent(this.ci);

  @override
  List<Object?> get props => [ci];
}

class UserCreate extends UserEvent {
  final Users users;

  const UserCreate(this.users);
  @override
  List<Object?> get props => [users];
}

class DeleteUser extends UserEvent {
  final String ci;

  const DeleteUser(this.ci);
  @override
  List<Object?> get props => [ci];
}

class UserInitialData extends UserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PutUserEvent extends UserEvent {
  final Users user;

  const PutUserEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class ChangeRoleEvent extends UserEvent {
  final String role;

  const ChangeRoleEvent(this.role);
  @override
  List<Object?> get props => [role];
}

class LogoutEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends FormEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends FormEvent {}

class PasswordChanged extends FormEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends FormEvent {}

class FormSubmitted extends FormEvent {}
