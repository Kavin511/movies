class MovieException implements Exception{
  final _message;
  final _prefix;
  MovieException([
    this._message,
    this._prefix
]);
  String toString(){
    return "$_prefix$_message";
  }
}
class FetchDataException extends MovieException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}
class BadRequestException extends MovieException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}
class UnauthorisedException extends MovieException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}
class InvalidInputException extends MovieException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}