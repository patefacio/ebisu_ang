library ebisu_ang.directive;

import 'package:ebisu_ang/entity.dart';

// custom <additional imports>
// end <additional imports>

class Directive extends Entity {
  Directive(id) : super(id);

  String get selector => _selector;
  List<String> get providers => _providers;

  // custom <class Directive>
  // end <class Directive>

  String _selector;
  List<String> _providers = [];
}

// custom <library directive>
// end <library directive>
