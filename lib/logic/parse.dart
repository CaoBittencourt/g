library;

import 'package:args/args.dart' show ArgParser;
import "package:g/logic/parse/p.dart" show pParser;
import "package:g/logic/parse/d.dart" show dParser;
import "package:g/logic/parse/l.dart" show lParser;
import "package:g/logic/parse/mm.dart" show mmParser;
import "package:g/logic/parse/g.dart" show gParser;

abstract class parse {
  static ArgParser g() => gParser();
  static ArgParser p() => pParser();
  static ArgParser d() => dParser();
  static ArgParser l() => lParser();
  static ArgParser mm() => mmParser();
}
