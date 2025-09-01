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

  static Future<void> __() async {
    await ut.cmd([gitStatus]);
  }

  static Future<void> commit(String msg) async {
    await ut.cmd([g.gitAddAll, g.gitStatus, g.gitCommit(msg)]);
  }

  // static mm() async {
  //   Process.start("sh", [
  //     "-c",
  //     "git checkout -b temp origin/HEAD",
  //     "git merge origin/dev",
  //     "git push origin HEAD:master",
  //     "git checkout dev",
  //     "git branch -D tem",
  //   ]);
  //   Process gitAdd = await Process.start("git", [
  //     "-c",
  //     "color.ui=always",
  //     "add",
  //     "-A",
  //   ]);

  //   stdout.addStream(gitAdd.stdout);
  //   stderr.addStream(gitAdd.stderr);

  //   // await g.__();

  //   Process gitCommit = await Process.start("git", [
  //     "-c",
  //     "color.ui=always",
  //     "commit",
  //     "-m",
  //     msg,
  //   ]);

  //   stdout.addStream(gitCommit.stdout);
  //   stderr.addStream(gitCommit.stderr);
  // }
}

cli.ArgParser pParser() {
  return cli.ArgParser()..addFlag(
    "friendly",
    abbr: "f",
    negatable: false,
    help: "Friendly push to remote (i.e. git push --force).",
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
      if (results.command!.flag("friendly")) {
        print("g p friendly flag");
      } else {
        print("g p");
      }

      // Process the parsed arguments.

      // // Act on the arguments provided.
      // print("Positional arguments: ${results.rest}");
      // if (verbose) {
      //   print("[VERBOSE] All arguments: ${results.arguments}");
      // }
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
