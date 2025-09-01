import 'dart:convert' show utf8;
import 'package:g/utils.dart' as ut;

const String _git = "git";

const String _color = "-c color.ui=always";

const String status = "$_git $_color status";

const String addAll = "$_git add -A";

const String _currentBranch =
    "$_git rev-parse --abbrev-ref --symbolic-full-name HEAD";

const String _currentHead =
    "$_git rev-parse --abbrev-ref --symbolic-full-name @{u}";

String commit(String msg) => "$_git commit -m '$msg'";

String checkout({required String branch, String? from, bool b = false}) =>
    "$_git checkout${b ? ' -b ' : ' '}$branch${from == null ? '' : ' $from'}";

String deleteBranch(String branch) => "$_git branch -D $branch";

String push({bool friendly = false, String? to}) =>
    "$_git push ${friendly ? '--force ' : ''}${to ?? ''}";

Future<String> currentBranch() async => (await (await ut.cmd([
  _currentBranch,
])).stdout.transform(utf8.decoder).join()).trim();

Future<String> currentHead() async => (await (await ut.cmd([
  _currentHead,
])).stdout.transform(utf8.decoder).join()).trim();

String merge(String branch) => "$_git $_color merge $branch";
