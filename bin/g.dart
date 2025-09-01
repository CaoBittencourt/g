import "package:g/data.dart" as dt;
import "package:g/logic.dart" as lc;
import "package:g/utils.dart" as ut;

import "package:args/args.dart" as cli;
import "dart:convert" show utf8;

const String program = "g";
const String version = "0.0.1";

cli.ArgParser pParser() {
  return cli.ArgParser()
    ..addFlag(
      "friendly",
      abbr: "f",
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

cli.ArgParser mmParser() {
  return cli.ArgParser()..addFlag(
    "help",
    abbr: "h",
    negatable: false,
    help: "Print this usage information.",
  );
}

cli.ArgParser buildParser() {
  return cli.ArgParser()
    ..addCommand("p", pParser())
    ..addCommand("mm", mmParser())
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Print this usage information.",
    )
    ..addFlag("version", negatable: false, help: "Print the tool version.");
}

void printUsage(cli.ArgParser argParser) {
  // print(argParser.commands.keys);
  print("Usage: $program <flags> [arguments]");
  print(argParser.usage);
}

Future<void> main(List<String> args) async {
  final cli.ArgParser argParser = buildParser();
  try {
    final cli.ArgResults results = argParser.parse(args);

    if (results.command == null) {
      if (results.arguments.isEmpty) {
        await lc.g.status();
        return;
      }

      if (results.flag("help")) {
        printUsage(argParser);
        return;
      }

      if (results.flag("version")) {
        print("$program version: $version");
        return;
      }
    }

    if (results.command?.name == "p") {
      if (results.command!.flag("help")) {
        printUsage(argParser.commands["p"]!);
        return;
      }

      await lc.g.p(results.command?.flag("friendly") ?? false);
      return;
    }

    if (results.command?.name == "mm") {
      await lc.g.mm();
      return;
    }

    // otherwise, commit with message
    await lc.g.commit(results.arguments.join(" "));
    return;
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print("");
    printUsage(argParser);
  }
}
