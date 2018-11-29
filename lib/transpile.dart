import './src/transpiler/lexer.dart';
import 'src/tokens/token.dart';

String transpiler(String source, List rules) {
  List<Token> tokens = lexer(source, rules);
  return tokens
      .map((Token token) => '${token.type.toUpperCase()} ${token.lexeme}')
      .join('\n');
}
