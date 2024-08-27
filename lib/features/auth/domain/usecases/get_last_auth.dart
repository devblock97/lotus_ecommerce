
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/core/domain/usecase/usecase.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class GetLastUserInfo extends UseCase<AuthResponseModel?, NoParams> {

  final AuthRepository authRepository;
  GetLastUserInfo(this.authRepository);

  @override
  Future<Either<Failure, AuthResponseModel?>> call(NoParams params) async {
    return await authRepository.getUserInfo();
  }

}