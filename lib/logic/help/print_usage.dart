import 'package:args/args.dart' as cli;

const String program = "g";
const String version = "0.0.1";

void printUsage(cli.ArgParser argParser) {
  final Map<String, cli.ArgParser> commands = argParser.commands;
  if (commands.isEmpty) {
    // print(argParser.commands.keys);
    print("Usage: $program <flags> [arguments]");
    print(argParser.usage);
    print("\n");
    return;
  }

  print("Usage: $program <command> <flags> [arguments]");
  print("  dsds lalala");
  print("\n");
  print("Subcommands:");
  for (final element in commands.entries) {
    print("  ${element.key}");
    print("    dsds lalala");
    print("\n");
    // print(element.value.usage);
  }
}
