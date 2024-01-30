
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/sign_in_model.dart';
import '../../data/models/sign_up_model.dart';

abstract class AuthRepository {

  Future<Either<Failure, AuthResponseModel>> signIn(AuthModel body)
    => throw UnimplementedError('Stub!');

  Future<Either<Failure, void>> signOut() => throw UnimplementedError('Stub!');

  Future<Either<Failure, UserModel>> signUp(SignUpModel body) => throw UnimplementedError('Stub!');
}