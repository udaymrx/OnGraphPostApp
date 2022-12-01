class BadRequestException implements Exception {
  final String _message;

  BadRequestException(
      [this._message =
          "Invalid request message framing or required headers are missing."]);

  @override
  String toString() {
    return _message;
  }
}

class UnauthorisedException implements Exception {
  final String _message;

  UnauthorisedException([this._message = "Not Authorized for this Content !"]);

  @override
  String toString() {
    return _message;
  }
}

class NotFoundException implements Exception {
  final String _message;

  NotFoundException(
      [this._message =
          "You are requesting for the resource that doesn't exists !"]);

  @override
  String toString() {
    return _message;
  }
}

class InvalidFormatException implements Exception {
  final String _message;

  InvalidFormatException([this._message = "Invalid Data Format"]);

  @override
  String toString() {
    return _message;
  }
}

class ServerException implements Exception {
  final String _message;

  ServerException([this._message = "Server is facing some issue"]);

  @override
  String toString() {
    return _message;
  }
}

class NoInternetException implements Exception {
  final String _message;

  NoInternetException(
      [this._message = "No Internet Connection,  Please connect to internet."]);

  @override
  String toString() {
    return _message;
  }
}

class UnKnownException implements Exception {
  final String _message;

  UnKnownException([this._message = "Something went Wrong"]);

  @override
  String toString() {
    return _message;
  }
}
