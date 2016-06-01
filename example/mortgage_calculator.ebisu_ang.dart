import 'package:ebisu_ang/ebisu_ang.dart';
import 'package:ebisu/ebisu.dart';
import 'package:logging/logging.dart';
import 'package:ebisu_ang/component.dart';

main() {

  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.INFO;

  Installation mortgageCalculator =
    installation('mortgage_calculator')
    ..rootPath = '/tmp/mortgage_calculator'
    ..appComponent = component('mortgage_calculator')
      ..components = [
        component('mortgage_details'),
        component('mortgage_schedule'),
      ];

  mortgageCalculator.generate();

  //mortgageCalculator.generate();
}