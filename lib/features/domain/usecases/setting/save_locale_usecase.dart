import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class SaveLocaleUseCase implements UseCase<bool,Params>{
  final ZanaStorageRepository repository;
  SaveLocaleUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    // TODO: implement call
    return repository.saveLocale(params.boolValue);
  }

}