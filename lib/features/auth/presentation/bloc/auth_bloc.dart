
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/sign_in_model.dart';
import '../../domain/usecases/post_sign_in.dart';
import '../../domain/usecases/post_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final PostSignIn? postSignIn;
  final PostSignUp? postSignUp;

  AuthBloc(this.postSignIn, this.postSignUp) : super(const AuthenticationInitialize())  {
    on<SignInRequest>(_onSignInRequest);
    on<SignUpRequest>(_onSignUpRequest);
  }

  void _onSignInRequest(SignInRequest event, Emitter<AuthState> emit) async {
    emit(const AuthenticationLoading());
    final response = await postSignIn!(ParamPostSignIn(event.authModel));
    print('auth bloc response: $response');
    response.fold(
      (l) {
        print('checking left: $l');
        if (l is ServerFailure) {
          emit(const AuthenticationError(code: 500, 'Failed to response from server'));
        }
        if (l is ConnectionFailure) {
          emit(const AuthenticationError(code: 503, 'Internet connection failure!'));
        }
        if (l is InputInvalid) {
          print('user invalid emit');
          emit(const AuthenticationInvalid(error: 'Tên đăng nhập hoặc mật khẩu không hợp lệ'));
        }
      },
      (r) => emit(AuthenticationSuccess(r))
    );
  }

  void _onSignUpRequest(SignUpRequest event, Emitter<AuthState> emit) async {
    emit(const AuthenticationLoading());
    final response = await postSignUp!(ParamPostSignUp(event.body));
    print('sign up response: ${response.toString()}');
    response.fold(
      (l) {
        if (l is ServerFailure) {
          emit(const AuthenticationError(code: 500, 'Failed to response from server'));
        }
        if (l is ConnectionFailure) {
          emit(const AuthenticationError(code: 503, 'Internet connection failure'));
        }
      },
      (r) => emit(SignUpSuccess(r))
    );
  }

}