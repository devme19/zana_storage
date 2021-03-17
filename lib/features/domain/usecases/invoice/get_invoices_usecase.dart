import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/invoice_entity.dart';
import 'package:zana_storage/features/domain/entities/invoice_table_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetInvoicesUseCase implements UseCase<InvoiceTableEntity,Params>{
  final ZanaStorageRepository repository;
  GetInvoicesUseCase({this.repository});

  @override
  Future<Either<Failure, InvoiceTableEntity>> call(Params params) {
    // TODO: implement call
    return repository.getInvoices(params.body);
  }
}