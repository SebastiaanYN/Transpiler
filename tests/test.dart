import 'dart:convert';
import 'dart:io';

import '../lib/transpile.dart';

void main() {
  List lexRules =
      jsonDecode(new File('../rules/lexer.json').readAsStringSync());
  List parseRules =
      jsonDecode(new File('../rules/parser.json').readAsStringSync());

  String input = new File('../input.txt').readAsStringSync();
  //String output = new File('../output.txt').readAsStringSync();

  String transpiled = transpile(input, lexRules, parseRules);
  print(transpiled);

  //assert(transpiled == output);
}
