import "dart:io";

import "package:g/data.dart" as dt;
import "package:g/logic.dart" as lc;
import "package:g/utils.dart" as ut;

import "package:args/args.dart" as cli;

Future<void> main(List<String> args) async {
  final cli.ArgParser argParser = lc.parse.g();

  try {
    final cli.ArgResults results = argParser.parse(args);

    switch (results.command?.name) {
      case dt.commands.p:
        if (results.command!.flag("help")) {
          lc.printUsage(argParser.commands[dt.commands.p]!);
          return;
        }

        await lc.g.p(results.command?.flag("friendly") ?? false);
        return;
      case dt.commands.d:
        if (results.command!.flag("help")) {
          lc.printUsage(argParser.commands[dt.commands.d]!);
          return;
        }

        await lc.g.d();
        return;
      case dt.commands.l:
        if (results.command!.flag("help")) {
          lc.printUsage(argParser.commands[dt.commands.l]!);
          return;
        }

        await lc.g.l();
        return;
      case dt.commands.mm:
        if (results.command!.flag("help")) {
          lc.printUsage(argParser.commands[dt.commands.mm]!);
          return;
        }

        await lc.g.mm(results.command?.flag("friendly") ?? false);
        return;
      case dt.commands.release:
        if (results.command!.flag("help")) {
          lc.printUsage(argParser.commands[dt.commands.release]!);
          return;
        }

        await lc.g.release(results.command?.flag("friendly") ?? false);
        return;
      case dt.commands.repo:
        if (results.command!.flag("help")) {
          lc.printUsage(argParser.commands[dt.commands.repo]!);
          return;
        }

        if (results.command!.arguments.isEmpty) {
          print("Error: Must provide a repo name!");
          exit(1);
        }

        await lc.g.repo(
          name: results.command!.arguments[0],
          public: results.command!.flag("public"),
        );

        return;
      default:
        if (results.arguments.isEmpty) {
          await lc.g.status();
          return;
        } // git status

        if (results.flag("help")) {
          lc.printUsage(argParser);
          return;
        }

        if (results.flag("version")) {
          print("${lc.program} version: ${lc.version}");
          return;
        }

        await lc.g.commit(results.arguments.join(" "));
        exit(0);
      // return; // otherwise, commit with message
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print("");
    lc.printUsage(argParser);
  }
}
