import 'package:zana_storage/features/data/model/error_model.dart';

class ErrorEntity{
  MessageModel message;
  int status;
  ErrorEntity({
    this.message,
    this.status
});
}