import "dart:io";

import "package:args/args.dart" as cli;

import "package:g/data.dart" as dt;
import "package:g/logic.dart" as lc;
import "package:g/utils.dart" as ut;

const String program = "g";
const String version = "0.0.1";

abstract class g {
  static const String git = "git -c color.ui=always";
  static const String gitStatus = "$git status";
  static const String gitAddAll = "$git add -A";

  static String gitCommit(String msg) => "${g.git} commit -m '$msg'";
  static String gitCheckout(String branch, {String? from}) => from == null
      ? "$git checkout -b $branch"
      : "$git checkout -b $branch $from";
  static String gitDeleteBranch(String branch) => "$git branch -D $branch";
  static String gitPush(bool friendly) =>
      friendly ? "$git push --force" : "$git push";

  static Future<void> __() async {
    await ut.cmd([gitStatus]);
  }

  static Future<void> commit(String msg) async {
    await ut.cmd([g.gitAddAll, g.gitStatus, g.gitCommit(msg)]);
  }

  static Future<void> p(bool friendly) async {
    await ut.cmd([g.gitPush(friendly)]);
  }
}

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

cli.ArgParser buildParser() {
  return cli.ArgParser()
    ..addCommand("p", pParser())
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Print this usage information.",
    )
    ..addFlag("version", negatable: false, help: "Print the tool version.");
}

void printUsage(cli.ArgParser argParser) {
  print("Usage: $program <flags> [arguments]");
  print(argParser.usage);
}

Future<void> main(List<String> args) async {
  final cli.ArgParser argParser = buildParser();
  try {
    final cli.ArgResults results = argParser.parse(args);

    if (results.command == null) {
      if (results.arguments.isEmpty) {
        await g.__();
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
      await g.p(results.command?.flag("friendly") ?? false);
      return;
    }

    // otherwise, commit with message
    await g.commit(results.arguments.join());
    return;
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print("");
    printUsage(argParser);
  }
}
