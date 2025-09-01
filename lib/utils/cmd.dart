import 'dart:io' show Process, stderr, stdout;

Future<Process> cmd(List<String> commands) async {
  Process pro = await Process.start("sh", ["-c", commands.join(" && ")]);
  stdout.addStream(pro.stdout);
  stderr.addStream(pro.stderr);
  return pro;
}
