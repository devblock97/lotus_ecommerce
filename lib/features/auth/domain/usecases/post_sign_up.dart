
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class PostSignUp extends UseCase<UserModel, ParamPostSignUp> {

  AuthRepository authRepository;

  PostSignUp(this.authRepository);

  @override
  Future<Either<Failure, UserModel>> call(params) async {
    return await authRepository.signUp(params.body);
  }
}

class ParamPostSignUp extends Equatable {
  final SignUpModel body;
  const ParamPostSignUp(this.body);

  @override
  List<Object?> get props => [body];

}