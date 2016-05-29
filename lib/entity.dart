library ebisu_ang.entity;

import 'package:id/id.dart';

// custom <additional imports>
// end <additional imports>

class Identifiable {
  Identifiable(this._id);

  /// Id for the [Identifiable]
  Id get id => _id;

  // custom <class Identifiable>
  // end <class Identifiable>

  Id _id;
}

class Entity extends Identifiable {
  Entity(id) : super(id);

  // custom <class Entity>

  // end <class Entity>

}

abstract class Htmlable {
  // custom <class Htmlable>

  get html;

  // end <class Htmlable>

}

// custom <library entity>
// end <library entity>
