library ebisu_ang.entity;

// custom <additional imports>
// end <additional imports>

abstract class Identifiable {
  /// Id for the [Identifiable]
  Id id;

  // custom <class Identifiable>
  // end <class Identifiable>

}

abstract class Entity extends Object with Identifiable {
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
