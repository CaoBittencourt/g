import 'package:args/args.dart' as cli;

cli.ArgParser dParser() {
  return cli.ArgParser()..addFlag(
    "help",
    abbr: "h",
    negatable: false,
    help: "Print this usage information.",
  );
}
