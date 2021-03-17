import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/add_product_response_entity.dart';
import 'package:zana_storage/features/domain/entities/product_entity3.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetProductByIdUseCase implements UseCase<ProductEntity3,Params>{
  final ZanaStorageRepository repository;
  GetProductByIdUseCase({this.repository});

  @override
  Future<Either<Failure, ProductEntity3>> call(Params params) {
    // TODO: implement call
    return repository.getProduct(params.id);
  }

}