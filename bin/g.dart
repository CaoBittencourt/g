import "dart:convert";
import "dart:io";

import "package:args/args.dart" as cli;

import "package:g/data.dart" as dt;
import "package:g/logic.dart" as lc;
import "package:g/utils.dart" as ut;

const String program = "g";
const String version = "0.0.1";

abstract class g {
  static const String _git = "git -c color.ui=always";
  static const String _gitStatus = "$_git status";
  static const String _gitAddAll = "$_git add -A";
  static const String _gitCurrentBranch =
      "$_git rev-parse --abbrev-ref --symbolic-full-name HEAD";
  static const String _gitCurrentHead =
      "$_git rev-parse --abbrev-ref --symbolic-full-name @{u}";

  static String gitCommit(String msg) => "${g._git} commit -m '$msg'";
  static String gitCheckout({required String branch, String? from}) =>
      from == null
      ? "$_git checkout -b $branch"
      : "$_git checkout -b $branch $from";
  static String gitDeleteBranch(String branch) => "$_git branch -D $branch";
  static String gitPush({bool friendly = false, String? to}) =>
      friendly ? "$_git push --force ${to ?? ""}" : "$_git push ${to ?? ""}";
  static Future<String> gitCurrentBranch() async => (await ut.cmd([
    g._gitCurrentBranch,
  ])).stdout.transform(utf8.decoder).join();
  static Future<String> gitCurrentHead() async =>
      (await ut.cmd([g._gitCurrentHead])).stdout.transform(utf8.decoder).join();
  static String gitMerge(String branch) => "$_git merge $branch";

  static Future<void> __() async {
    await ut.listen(ut.cmd([_gitStatus]));
  }

  static Future<void> commit(String msg) async {
    await ut.listen(ut.cmd([g._gitAddAll, g._gitStatus, g.gitCommit(msg)]));
  }

  static Future<void> p(bool friendly) async {
    await ut.listen(ut.cmd([g.gitPush()]));
  }

  static Future<void> mm() async {
    final String currentBranch = await g.gitCurrentBranch();
    final String currentHead = await g.gitCurrentHead();
    await ut.listen(
      ut.cmd([
        g.gitCheckout(branch: "temp", from: "origin/HEAD"),
        g.gitMerge(currentHead),
        g.gitPush(to: "origin HEAD:master"),
        g.gitCheckout(branch: currentBranch),
        g.gitDeleteBranch("temp"),
      ]),
    );
  }

  // static Future<void> mm() async {
  //   "current=$(git rev-parse --abbrev-ref --symbolic-full-name HEAD) &&"
  //   "currentHead=$(git rev-parse --abbrev-ref --symbolic-full-name @{u}) &&"
  //   "echo \"current: $current\" &&"
  //   "echo \"currentHead: $currentHead\" &&"
  //   "git checkout -b temp origin/HEAD &&"
  //   "git merge $currentHead &&"
  //   "git push origin HEAD:master &&"
  //   "git checkout $current &&"
  //   "git branch -D temp &&"
  //   "unset current &&"
  //   "unset currentHead",
  // }
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

    if (results.command?.name == "mm") {
      print("g mm");
      await g.mm();
      return;
    }

    // otherwise, commit with message
    await g.commit(results.arguments.join(" "));
    return;
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print("");
    printUsage(argParser);
  }
}
