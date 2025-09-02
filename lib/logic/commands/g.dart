import 'package:g/logic/commands/git.dart' as git;
import 'package:g/utils.dart' as ut;

abstract class g {
  static const String _tempBranch = "temp";
  static Future<void> status() async {
    await ut.listen(ut.cmd([git.status]));
  }

  static Future<void> commit(String msg) async {
    await ut.listen(ut.cmd([git.addAll, git.status, git.commit(msg)]));
  }

  static Future<void> p(bool friendly) async {
    if (friendly) {
      ut.warn.friendly(await git.currentBranch());
    }

    await ut.listen(ut.cmd([git.push(friendly)]));
  }

  static Future<void> d() async {
    await ut.listen(ut.cmd([git.diff]));
  }

  static Future<void> l() async {
    await ut.listen(ut.cmd([git.log]));
  }

  static Future<void> _merge({
    required String to,
    required String remote,
    bool friendly = false,
  }) async {
    if (friendly) {
      ut.warn.friendly(to);
    }

    await ut.listen(
      ut.cmd([
        git.checkout(branch: _tempBranch, from: to, b: true),
        git.merge(await git.currentHead()),
        git.push(friendly, to: remote),
        git.checkout(branch: await git.currentBranch()),
        git.deleteBranch(_tempBranch),
      ]),
    );
  }

  static Future<void> mm(bool friendly) async {
    await _merge(
      to: "remotes/origin/HEAD",
      remote: "origin HEAD:master",
      friendly: friendly,
    );
  }

  static Future<void> release(bool friendly) async {
    await _merge(
      to: "remotes/origin/release",
      remote: "origin HEAD:release",
      friendly: friendly,
    );
  }
}
