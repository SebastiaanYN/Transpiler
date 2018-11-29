import 'dart:convert';
import 'dart:io';

import '../lib/transpile.dart';

void main() {
  List rules = jsonDecode(new File('../rules/lexer.json').readAsStringSync());

  String input = new File('../input.txt').readAsStringSync();
  //String output = new File('../output.txt').readAsStringSync();

  String transpiled = transpile(input, rules);
  print(transpiled);

  //assert(transpiled == output);
}
