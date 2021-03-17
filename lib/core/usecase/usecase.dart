import 'package:either_type/either_type.dart';
import 'package:equatable/equatable.dart';
import 'package:zana_storage/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
// ignore: must_be_immutable
class Params extends Equatable {
  final String body;
  final bool boolValue;
  String id;

  Params({this.body,this.boolValue,this.id});

  @override
  List<Object> get props => [body,boolValue,id];
}