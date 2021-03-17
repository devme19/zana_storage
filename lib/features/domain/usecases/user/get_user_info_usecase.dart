import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/user_info_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetUserInfoUseCase implements UseCase<UserInfoEntity,Params>{

  final ZanaStorageRepository repository;
  GetUserInfoUseCase({this.repository});

  @override
  Future<Either<Failure, UserInfoEntity>> call(Params params) {
    // TODO: implement call
    return repository.getUserInfo(params.boolValue);
  }

}