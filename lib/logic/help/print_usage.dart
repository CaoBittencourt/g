import 'package:args/args.dart' as cli;

const String program = "g";
const String version = "0.0.1";

void printUsage(cli.ArgParser argParser) {
  final Map<String, cli.ArgParser> commands = argParser.commands;
  if (commands.isEmpty) {
    // print(argParser.commands.keys);
    print("Usage: $program <flags> [arguments]");
    print(argParser.usage);
    print("");
    return;
  }

  print("Usage: $program <command> <flags> [arguments]");
  print("  dsds lalala");
  print("");
  print("Subcommands:");
  for (final element in commands.entries) {
    print("  ${element.key}");
    print("    dsds lalala");
    print("");
    // print(element.value.usage);
  }
}
