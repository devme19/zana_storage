import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/customer_table_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetCustomersUseCase implements UseCase<CustomerTableEntity,Params>{

  final ZanaStorageRepository repository;
  GetCustomersUseCase({this.repository});
  @override
  Future<Either<Failure, CustomerTableEntity>> call(Params params) {
    // TODO: implement call
    return repository.getCustomers(params.body);
  }

}