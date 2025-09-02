import 'package:args/args.dart' as cli;

cli.ArgParser lParser() {
  return cli.ArgParser()..addFlag(
    "help",
    abbr: "h",
    negatable: false,
    help: "Print this usage information.",
  );
}
