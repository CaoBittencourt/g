import "package:g/data.dart" as dt;
import "package:g/logic.dart" as lc;
import "package:g/utils.dart" as ut;

import "package:args/args.dart" as cli;

const String program = "g";
const String version = "0.0.1";

void printUsage(cli.ArgParser argParser) {
  // print(argParser.commands.keys);
  print("Usage: $program <flags> [arguments]");
  print(argParser.usage);
}

Future<void> main(List<String> args) async {
  final cli.ArgParser argParser = lc.parse.g();

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
