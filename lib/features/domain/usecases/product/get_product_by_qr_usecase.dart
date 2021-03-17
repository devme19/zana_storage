import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/qr_product_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetProductByQrUseCase implements UseCase<QrProductEntity,Params>{
  final ZanaStorageRepository repository;
  GetProductByQrUseCase({this.repository});

  @override
  Future<Either<Failure, QrProductEntity>> call(Params params) {
    // TODO: implement call
    return repository.getProductByQr(params.body);
  }
}