import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:http/http.dart' as http;
import 'package:zana_storage/features/domain/entities/response_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class CreateInvoiceUseCase implements UseCase<ResponseEntity,Params>{
  final ZanaStorageRepository repository;
  CreateInvoiceUseCase({this.repository});

  @override
  Future<Either<Failure, ResponseEntity>> call(Params params) {
    // TODO: implement call
    return repository.createInvoice(params.body);
  }

}