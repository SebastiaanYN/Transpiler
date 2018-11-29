import '../errors/invalid_token.dart';
import '../tokens/token.dart';

List<Token> lex(String source, List rules) {
  List<Token> tokens = List();
  List<String> lines = source.split('\n');

  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];

    while (line.isNotEmpty) {
      bool invalid = true;

      for (var rule in rules) {
        RegExp regex = RegExp(rule['match']);

        Match match = regex.firstMatch(line);
        if (match == null || match.start != 0) continue;

        tokens.add(Token(line.substring(match.start, match.end), rule['type'],
            match.start, i));
        line = line.substring(match.end);

        invalid = false;
        break;
      }

      if (invalid) {
        int col = lines[i].indexOf(line);
        throw InvalidTokenError('Invalid token "${line[0]}" at $i:$col');
      }
    }
  }

  return tokens;
}
