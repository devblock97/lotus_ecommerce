
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

class PostSignIn extends UseCase<AuthResponseModel, ParamPostSignIn> {

  final AuthRepository authRepository;

  PostSignIn({required this.authRepository});

  @override
  Future<Either<Failure, AuthResponseModel>> call(ParamPostSignIn params) async {
    return await authRepository.signIn(params.authModel);
  }
}

class ParamPostSignIn extends Equatable {
  final AuthModel authModel;
  const ParamPostSignIn(this.authModel);

  @override
  List<Object?> get props => [authModel];

}