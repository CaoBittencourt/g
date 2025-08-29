import 'package:args/args.dart' as cli;

import 'package:g/data.dart' as dt;
import 'package:g/logic.dart' as lc;
import 'package:g/utils.dart' as ut;

const String version = '0.0.1';

cli.ArgParser buildParser() {
  return cli.ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag('version', negatable: false, help: 'Print the tool version.');
}

void printUsage(cli.ArgParser argParser) {
  print('Usage: dart dsds.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final cli.ArgParser argParser = buildParser();
  try {
    final cli.ArgResults results = argParser.parse(arguments);
    bool verbose = false;

    // Process the parsed arguments.
    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('dsds version: $version');
      return;
    }
    if (results.flag('verbose')) {
      verbose = true;
    }

    // Act on the arguments provided.
    print('Positional arguments: ${results.rest}');
    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
