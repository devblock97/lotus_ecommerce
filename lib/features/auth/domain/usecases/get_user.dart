import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/data/models/auth_response_model.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUser {

  GetUser(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, AuthResponseModel?>> getUser() async {
    final response = await repository.getUserInfo();
    return response;
  }
}