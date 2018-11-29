/// A lexer token
class Token {
  /// The lexeme value of the token
  final String lexeme;

  /// The type of the token
  final String type;

  /// The row the token is positioned on
  final int row;

  /// The column the token is positioned on
  final int col;

  /// Create a token
  Token(this.lexeme, this.type, this.row, this.col);
}
