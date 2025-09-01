import 'dart:io' show Process;

Future<Process> cmd(List<String> commands) async {
  print("command: ${commands.join(" && ")}\n");
  return await Process.start("sh", ["-c", commands.join(" && ")]);
}
