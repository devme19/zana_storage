import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/product_table_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetProductsUseCase implements UseCase<ProductTableEntity,Params>{
  final ZanaStorageRepository repository;
  GetProductsUseCase({this.repository});

  @override
  Future<Either<Failure, ProductTableEntity>> call(Params params) {
    // TODO: implement call
    return repository.getProducts(params.body);
  }

}