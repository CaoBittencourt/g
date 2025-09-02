import 'package:g/logic/commands/git.dart' as git;
import 'package:g/utils.dart' as ut;

const String _tempBranch = "temp";

abstract class g {
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

  static Future<void> mm(bool friendly) async {
    const String to = "origin HEAD:master";

    if (friendly) {
      ut.warn.friendly(to);
    }

    await ut.listen(
      ut.cmd([
        git.checkout(branch: _tempBranch, from: "origin/HEAD", b: true),
        git.merge(await git.currentHead()),
        git.push(friendly, to: to),
        git.checkout(branch: await git.currentBranch()),
        git.deleteBranch(_tempBranch),
      ]),
    );
  }
}
