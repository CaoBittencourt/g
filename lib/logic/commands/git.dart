import 'dart:convert' show utf8;
import 'package:g/utils.dart' as ut;

const String _git = "git";

const String _color = "-c color.ui=always";

const String status = "$_git $_color status";
const String diff = "$_git $_color diff | less"; // [task]
const String log = "$_git $_color log | less"; // [task]

const String addAll = "$_git add -A";

const String _currentBranch =
    "$_git rev-parse --abbrev-ref --symbolic-full-name HEAD";

const String _currentHead =
    "$_git rev-parse --abbrev-ref --symbolic-full-name @{u}";

String commit(String msg) => "$_git commit -m '$msg'";

String checkout({required String branch, String? from, bool b = false}) =>
    "$_git checkout${b ? ' -b ' : ' '}$branch${from == null ? '' : ' $from'}";

String deleteBranch(String branch) => "$_git branch -D $branch";

String push(bool friendly, {String to = "origin"}) =>
    "$_git push ${friendly ? '--force ' : ''}$to";

Future<String> currentBranch() async => (await (await ut.cmd([
  _currentBranch,
])).stdout.transform(utf8.decoder).join()).trim();

Future<String> currentHead() async => (await (await ut.cmd([
  _currentHead,
])).stdout.transform(utf8.decoder).join()).trim();

String merge(String branch) => "$_git $_color merge $branch";

String fetch({bool all = true}) => "$_git fetch ${all ? "--all" : ""}";

List<String> repo({
  required String name,
  String desc = "",
  bool public = false,
}) {
  return r"""
# create readme file 
# [task] add ":" only if repoDesc
echo "# repoName: repoDesc" > README.md

# create gitignore file
touch .gitignore

# create remote repo
gh repo create "repoName" -d "repoDesc" --visibility

# create local repo
git init --initial-branch master .
git add .
git commit -m 'initial commit'
git remote add origin "https://github.com/"$(git config user.name)"/repoName.git"
git push -u origin master

# official release branch
git checkout -b stable master
git push -u origin stable

# one dev branch per team
git checkout -b dev master
git push -u origin dev

# only keep dev branch locally
git branch -D master
git branch -D stable
"""
      .replaceAll("repoName", name)
      .replaceAll("repoDesc", desc)
      .replaceAll("--visibility", public ? "--public" : "--private")
      .split('\n')
      .where((element) => element.isNotEmpty)
      .where((element) => !element.startsWith("#"))
      .toList();
}
