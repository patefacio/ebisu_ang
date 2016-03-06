library ebisu_ang.test_component;

import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'package:ebisu_ang/component.dart';

// end <additional imports>

final _logger = new Logger('test_component');

// custom <library test_component>
// end <library test_component>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  test('component annotation', () {
    final annotation =
        componentAnnotation(directives: ['foo', 'bar'], selector: 'bam-bam');
    print(annotation);
  });

  test('component construction', () {});

  print((new IoExpr('boo')).htmlAttrVal);
  print((input('bam', new IExpr('boo'))).html);
  print((output('bam', new OExpr('bammama(\$event)'))).html);

// end <main>
}
