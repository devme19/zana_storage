import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/init_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class InitUseCase implements UseCase<InitEntity,NoParams>{
  final ZanaStorageRepository repository;
  InitUseCase({this.repository});

  @override
  Future<Either<Failure, InitEntity>> call(NoParams params) {
    // TODO: implement call
    return repository.getInit();
  }

}