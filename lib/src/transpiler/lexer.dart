import '../errors/invalid_token.dart';
import '../tokens/token.dart';

List<Token> lex(String source, List rules) {
  List<Token> tokens = List();
  List<String> lines = source.split('\n');

  rules.forEach((var rule) => rule['regex'] = RegExp(rule['match']));

  for (int row = 0; row < lines.length; row++) {
    String line = lines[row];

    int col = 0;
    while (line.isNotEmpty) {
      bool invalid = true;

      for (var rule in rules) {
        Match match = rule['regex'].firstMatch(line);
        if (match == null || match.start != 0) continue;

        if (rule['ignore'] == null || !rule['ignore']) {
          tokens.add(Token(
              line.substring(match.start, match.end), rule['type'], row, col));
        }

        line = line.substring(match.end);
        col += match.end;

        invalid = false;
        break;
      }

      if (invalid) {
        int col = lines[row].indexOf(line);
        throw InvalidTokenError('Invalid token "${line[0]}" at $row:$col');
      }
    }
  }

  return tokens;
}
