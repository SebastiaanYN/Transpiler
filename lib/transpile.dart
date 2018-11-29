import './src/transpiler/lexer.dart';
import 'src/tokens/token.dart';

String transpile(String source, List rules) {
  List<Token> tokens = lex(source, rules);
  return tokens
      .map((Token token) => '${token.type.toUpperCase()} ${token.lexeme}')
      .join('\n');
}
