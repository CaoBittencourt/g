import 'package:args/args.dart' as cli;

cli.ArgParser mmParser() {
  return cli.ArgParser()
    ..addFlag(
      "friendly",
      abbr: "f",
      defaultsTo: false,
      negatable: false,
      help: "Friendly push to remote (i.e. git push --force).",
    )
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Print this usage information.",
    );
}
