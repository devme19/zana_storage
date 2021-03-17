import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/invoice_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetInvoiceUseCase implements UseCase<InvoiceEntity,Params>{
  final ZanaStorageRepository repository;
  GetInvoiceUseCase({this.repository});

  @override
  Future<Either<Failure, InvoiceEntity>> call(Params params) {
    // TODO: implement call
    return repository.getInvoice(params.body);
  }

}