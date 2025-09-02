import 'dart:io' show Process;

Future<Process> cmd(List<String> commands) async {
  return await Process.start("sh", ["-c", commands.join(" && echo && ")]);
}
