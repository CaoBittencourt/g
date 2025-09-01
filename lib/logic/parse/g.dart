import 'package:args/args.dart' as cli;
import 'package:g/logic.dart' as lc;

cli.ArgParser gParser() {
  return cli.ArgParser()
    ..addCommand("p", lc.parse.p())
    ..addCommand("mm", lc.parse.mm())
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Print this usage information.",
    )
    ..addFlag("version", negatable: false, help: "Print the tool version.");
}
