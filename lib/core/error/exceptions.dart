class ServerException implements Exception {
  int errorCode;
  List<String> errorMessage;
  ServerException({this.errorCode,this.errorMessage});
  int getErrorCode() {return errorCode;}
}

class CacheException implements Exception {}
