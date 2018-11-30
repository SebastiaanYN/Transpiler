import '../errors/invalid_token.dart';
import '../tokens/token.dart';

List<Token> parse(List<Token> tokens, List rules) {
  List<Token> outputTokens = List();

  rules.forEach((var rule) {
    List<String> types =
        (rule['match'] as String).split(' ').map((String type) {
      int index = type.indexOf('(');
      return type.substring(0, index < 0 ? type.length : index);
    }).toList();

    rule['types'] = types;
  });

  for (int t = 0; t < tokens.length; t++) {
    bool valid = false;
    var rule;

    for (int r = 0; r < rules.length; r++) {
      rule = rules[r];

      // Check the types of the rule
      for (int i = 0; i < rule['types'].length; i++) {
        if (tokens[t + i].type == rule['types'][i]) {
          valid = true;
        } else {
          valid = false;
          break;
        }
      }

      if (valid) {
        // We found the right token, we don't need to check the other rules
        break;
      }
    }

    if (valid) {
      // Token matches
      outputTokens.add(parseMatch(
          tokens.getRange(t, t + rule['types'].length).toList(), rule));

      t += rule['types'].length - 1;
    } else {
      // Token doesn't match
      throw InvalidTokenError(
          'Invalid ${tokens[t].type} "${tokens[t].lexeme}" at ${tokens[t].row}:${tokens[t].col}');
    }
  }

  return outputTokens;
}

Token parseMatch(List<Token> tokens, var rule) {
  String lexeme = '';

  String output = rule['output'];
  for (int i = 0; i < output.length; i++) {
    String sub = output.substring(i);

    Match match;
    if ((match = RegExp(r'^\$(\d+)(?:\.(\d+))?').firstMatch(sub)) != null) {
      int index = int.parse(match.group(1)) - 1;
      if (match.group(2) == null) {
        // Insert variable
        lexeme += tokens[index].lexeme;
      } else {
        // Insert regex group match
        String tokenType = (rule['match'] as String).split(' ')[index];
        tokenType = tokenType.substring(
            tokenType.indexOf('(') + 1, tokenType.length - 1);

        lexeme += RegExp(tokenType)
            .firstMatch(tokens[index].lexeme)
            .group(int.parse(match.group(2)));
      }

      i += match.group(0).length - 1;
    } else {
      lexeme += sub[0];
    }
  }

  return Token(lexeme, rule['type'], 0, 0);
}
