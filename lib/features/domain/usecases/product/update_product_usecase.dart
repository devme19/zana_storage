import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/product_entity3.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class UpdateProductUseCase implements UseCase<bool,Params>{
  final ZanaStorageRepository repository;
  UpdateProductUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.updateProduct(params.body, params.id);
  }
}