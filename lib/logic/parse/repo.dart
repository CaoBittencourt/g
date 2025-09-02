import 'package:args/args.dart' as cli;

cli.ArgParser repoParser() {
  return cli.ArgParser()
    ..addFlag("private", help: "dsds", defaultsTo: true)
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Print this usage information.",
    );
}
