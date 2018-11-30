import 'src/transpiler/lexer.dart';
import 'src/tokens/token.dart';
import 'src/transpiler/parser.dart';

String transpile(String source, List lexRules, List parseRules) {
  List<Token> tokens = lex(source, lexRules);
  tokens = parse(tokens, parseRules);

  return tokens
      .map((Token token) => '${token.type.toUpperCase()} ${token.lexeme}')
      .join('\n');
}
