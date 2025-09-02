import 'package:args/args.dart' as cli;

cli.ArgParser repoParser() {
  return cli.ArgParser()
    ..addFlag(
      "public",
      abbr: "p",
      help: "Whether the created repo should be public or private (default).",
      defaultsTo: false,
      negatable: false,
    )
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Print this usage information.",
    );
}
