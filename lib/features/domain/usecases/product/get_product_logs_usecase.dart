import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/product_log_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetProductLogsUseCase implements UseCase<ProductLogEntity,Params>{
  final ZanaStorageRepository repository;
  GetProductLogsUseCase({this.repository});

  @override
  Future<Either<Failure, ProductLogEntity>> call(Params params) {
    // TODO: implement call
    return repository.getProductLogs(params.body);
  }
}