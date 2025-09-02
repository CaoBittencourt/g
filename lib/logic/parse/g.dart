import 'package:args/args.dart' as cli;
import 'package:g/logic.dart' as lc;
import 'package:g/data.dart' as dt;

cli.ArgParser gParser() {
  return cli.ArgParser()
    ..addCommand(dt.commands.repo, lc.parse.repo())
    ..addCommand(dt.commands.p, lc.parse.p())
    ..addCommand(dt.commands.d, lc.parse.d())
    ..addCommand(dt.commands.l, lc.parse.l())
    ..addCommand(dt.commands.mm, lc.parse.mm())
    ..addCommand(dt.commands.release, lc.parse.release())
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Print this usage information.",
    )
    ..addFlag("version", negatable: false, help: "Print the tool version.");
}
