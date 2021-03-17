import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/customer_entity.dart';
import 'package:zana_storage/features/domain/entities/response_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class UpdateCustomerUseCase implements UseCase<CustomerEntity,Params>{
  final ZanaStorageRepository repository;
  UpdateCustomerUseCase({this.repository});

  @override
  Future<Either<Failure, CustomerEntity>> call(Params params) {
    // TODO: implement call
    return repository.updateCustomer(params.body, params.id);
  }

}