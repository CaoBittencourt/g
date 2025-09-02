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
    await ut.listen(ut.cmd([git.push(friendly: friendly)]));
  }

  static Future<void> mm() async {
    await ut.listen(
      ut.cmd([
        git.checkout(branch: _tempBranch, from: "origin/HEAD", b: true),
        git.merge(await git.currentHead()),
        git.push(to: "origin HEAD:master"),
        git.checkout(branch: await git.currentBranch()),
        git.deleteBranch(_tempBranch),
      ]),
    );
  }
}
