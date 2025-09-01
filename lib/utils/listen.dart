import 'dart:io' show Process, stdout, stderr;

Future<void> listen(Future<Process> pro) async {
  final Process _pro = await pro;
  stdout.addStream(_pro.stdout);
  stderr.addStream(_pro.stderr);
}
