import 'dart:convert';
import 'dart:io';

import '../lib/transpile.dart';

void main() async {
  List rules = jsonDecode(new File('../rules/lexer.json').readAsStringSync());

  new File('../input.txt').readAsString().then((String content) {
    print(transpiler(content, rules));
  });
}
