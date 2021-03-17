import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/login_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class LoginUseCase extends UseCase<LoginEntity,Params>{

  final ZanaStorageRepository repository;

  LoginUseCase({
    this.repository
  });

  @override
  Future<Either<Failure, LoginEntity>> call(Params params) {
    // TODO: implement call
    return repository.login(params.body);
  }

}