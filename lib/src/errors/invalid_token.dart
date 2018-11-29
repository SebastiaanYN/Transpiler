class InvalidTokenError extends Error {
  /// Message describing the error
  final String _message;

  /// Create an invalid token error when an invalid token is found where
  /// [_message] describes the error
  InvalidTokenError([this._message]);

  /// Convert the error to a string
  String toString() {
    return 'InvalidTokenError: $_message';
  }
}
