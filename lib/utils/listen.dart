import 'dart:io' show Process, stdout, stderr;

Future<void> listen(Future<Process> pro) async {
  stdout.addStream((await pro).stdout);
  stderr.addStream((await pro).stderr);
}
