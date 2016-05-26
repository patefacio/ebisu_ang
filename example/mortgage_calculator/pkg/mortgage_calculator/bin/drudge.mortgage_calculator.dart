import 'package:drudge/drudge.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'dart:io';

final _logger = new Logger('drudge_mortgage_calculator');

main() {
  String ebisuScript = '../../../../mortgage_calculator.ebisu_ang.dart';
  String libPath = 'mortgage_calculator/pkg/mortgage_calculator/lib';
  String testPath = 'mortgage_calculator/pkg/mortgage_calculator/test';
  String here = absolute(Platform.script.toFilePath());

  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:	${r.message}"));
  Logger.root.level = Level.FINE;

  _logger.info('''
Drudge($here)
  libPath: $libPath
  testPath: $testPath
''');

  final runTests = command('run_tests', 'dart', [ join(testPath, 'runner.dart') ]);
  driver([
    fileSystemEventRunner(
        changeSpec(FileSystemEvent.ALL, [ebisuScript]),
        recipe('regenerate', [
          command('regenerate', 'dart', [ ebisuScript ]),
          runTests
        ])),
    fileSystemEventRunner(
        changeSpec(FileSystemEvent.ALL, [ '${libPath}**.dart' ]),
        recipe('run_tests', [
          runTests
        ]))
  ]).run();

}
