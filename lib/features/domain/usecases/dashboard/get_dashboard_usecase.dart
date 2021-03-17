import 'package:either_type/src/either.dart';
import 'package:zana_storage/core/error/failures.dart';
import 'package:zana_storage/core/usecase/usecase.dart';
import 'package:zana_storage/features/domain/entities/dashboard_entity.dart';
import 'package:zana_storage/features/domain/repositories/zana_storage_repository.dart';

class GetDashboardUseCase implements UseCase<DashboardEntity,NoParams>{
  final ZanaStorageRepository repository;
  GetDashboardUseCase({this.repository});

  @override
  Future<Either<Failure, DashboardEntity>> call(NoParams params) {
    // TODO: implement call
    return repository.getDashboard();
  }

}