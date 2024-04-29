
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class CheckSignedIn extends AuthEvent {
  CheckSignedIn();
}

class SignOutRequest extends AuthEvent {
  SignOutRequest();
}

class SignInRequest extends AuthEvent {
  final AuthModel authModel;
  SignInRequest(this.authModel);

  @override
  List<Object?> get props => [authModel];
}

class SignUpRequest extends AuthEvent {
  final SignUpModel body;
  SignUpRequest(this.body);

  @override
  List<Object?> get props => [body];
}