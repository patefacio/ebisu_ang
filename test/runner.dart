import 'package:logging/logging.dart';
import 'test_component.dart' as test_component;
import 'test_entity.dart' as test_entity;

main() {
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  test_component.main();
  test_entity.main();
}
