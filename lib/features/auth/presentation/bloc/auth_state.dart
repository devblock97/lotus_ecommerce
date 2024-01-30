part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {

  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitialize extends AuthState {
  const AuthenticationInitialize();
}

class AuthenticationSuccess extends AuthState {
  final AuthResponseModel authResponseModel;
  const AuthenticationSuccess(this.authResponseModel);

  @override
  List<Object?> get props => [authResponseModel];
}

class SignUpSuccess extends AuthState {
  final UserModel userModel;
  const SignUpSuccess(this.userModel);

  @override
  List<Object?> get props => [userModel];
}

class AuthenticationError extends AuthState {
  final String error;
  const AuthenticationError(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthenticationLoading extends AuthState {
  const AuthenticationLoading();
}