import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/add_product_response_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class AddProductUseCase implements UseCase<AddProductResponseEntity,Params>{
  final ZanaStorageRepository repository;
  AddProductUseCase({this.repository});

  @override
  Future<Either<Failure, AddProductResponseEntity>> call(Params params) {
   return repository.addProduct(params.body);
  }

}