import 'package:ebisu_ang/ebisu_ang.dart';
import 'package:ebisu/ebisu.dart';
import 'package:logging/logging.dart';

main() {

  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;

  final mortgageCalculator =
    installation('mortgage_calculator')
    ..packages = [
      package('mortgage_calculator')
      ..appComponent = component('mortgage_calculator')
      ..components = [
        component('mortgage_details'),
        component('mortgage_schedule'),
      ]
    ];

  mortgageCalculator.generate();
}