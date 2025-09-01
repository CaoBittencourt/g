import 'dart:convert' show utf8;
import 'package:g/utils.dart' as ut;

abstract class g {
  static const String git = "git";
  static const String color = "-c color.ui=always";
  static const String gitStatus = "${g.git} ${g.color} status";
  static const String gitAddAll = "${g.git} add -A";
  static const String gitCurrentBranch =
      "${g.git} rev-parse --abbrev-ref --symbolic-full-name HEAD";
  static const String gitCurrentHead =
      "${g.git} rev-parse --abbrev-ref --symbolic-full-name @{u}";

  static String gitCommit(String msg) => "${g.git} commit -m '$msg'";
  static String gitCheckout({
    required String branch,
    String? from,
    bool b = false,
  }) =>
      "${g.git} checkout${b ? ' -b ' : ' '}$branch${from == null ? '' : ' $from'}";
  static String gitDeleteBranch(String branch) => "${g.git} branch -D $branch";
  static String gitPush({bool friendly = false, String? to}) =>
      "${g.git} push ${friendly ? '--force ' : ''}${to ?? ''}";
  static Future<String> gitGetCurrentBranch() async => (await (await ut.cmd([
    g.gitCurrentBranch,
  ])).stdout.transform(utf8.decoder).join()).trim();
  static Future<String> gitGetCurrentHead() async => (await (await ut.cmd([
    g.gitCurrentHead,
  ])).stdout.transform(utf8.decoder).join()).trim();
  static String gitMerge(String branch) => "${g.git} ${g.color} merge $branch";

  static Future<void> status() async {
    await ut.listen(ut.cmd([g.gitStatus]));
  }

  static Future<void> commit(String msg) async {
    await ut.listen(ut.cmd([g.gitAddAll, g.gitStatus, g.gitCommit(msg)]));
  }

  static Future<void> p(bool friendly) async {
    await ut.listen(ut.cmd([g.gitPush()]));
  }

  static Future<void> mm() async {
    await ut.listen(
      ut.cmd([
        g.gitCheckout(branch: "temp", from: "origin/HEAD", b: true),
        g.gitMerge(await g.gitGetCurrentHead()),
        g.gitPush(to: "origin HEAD:master"),
        g.gitCheckout(branch: await g.gitGetCurrentBranch()),
        g.gitDeleteBranch("temp"),
      ]),
    );
  }
}
