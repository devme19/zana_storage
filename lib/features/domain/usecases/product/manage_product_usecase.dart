import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/manage_product_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class ManageProductUseCase implements UseCase<ManageProductEntity,Params>{
  final ZanaStorageRepository repository;
  ManageProductUseCase({this.repository});

  @override
  Future<Either<Failure, ManageProductEntity>> call(Params params) {
    // TODO: implement call
    return repository.manageProduct(params.body, params.id);
  }

}