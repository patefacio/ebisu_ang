import 'package:ebisu_ang/ebisu_ang.dart';
import 'package:ebisu/ebisu.dart';
import 'package:logging/logging.dart';

main() {

  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;

  final dossier =
    installation('dossier')
    ..packages = [
      package('balance_sheet')
      ..appComponent = component('account'),
    ];

  dossier.generate();
}