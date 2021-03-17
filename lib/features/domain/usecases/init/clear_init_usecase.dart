import 'dart:ffi';

import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class ClearInitUseCase implements UseCase<bool,NoParams>{
  final ZanaStorageRepository repository;
  ClearInitUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    // TODO: implement call
    return repository.clearInit();
  }

}