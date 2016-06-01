library ebisu_ang.entity;

import 'package:ebisu/ebisu.dart' as ebisu;
import 'package:id/id.dart';
import 'package:logging/logging.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('entity');

class Identifiable {
  Identifiable(this._id);

  /// Id for the [Identifiable]
  Id get id => _id;

  // custom <class Identifiable>
  // end <class Identifiable>

  Id _id;
}

abstract class Entity extends Identifiable {
  Entity(id) : super(ebisu.makeId(id));

  /// Documentation for the angular entity
  String doc;
  Entity get owner => _owner;
  List<Entity> get entityPath => _entityPath;

  // custom <class Entity>

  Iterable<Entity> get children;

  setRootNode() => _setOwner(null);

  _setOwner(Entity newOwner) {
    bool isRoot = newOwner == null;

    if (_owner != null) {
      _logger.severe('Owner being set when already has value ${_owner.id}');
    }

    _owner = newOwner;
    onOwnershipEstablished();

    if (!isRoot) {
      _entityPath = []
        ..addAll(newOwner.entityPath)
        ..add(this);
    }

    _logger.info('SetOwner: ($id:${runtimeType}) to '
        '${newOwner == null? "root" : "(${newOwner.id}:${newOwner.runtimeType})"}');

    for (final child in children) {
      child._setOwner(this);
    }
  }

  onOwnershipEstablished() {
    _logger.info('Establishing ownership Entity ${runtimeType}');
  }

  // end <class Entity>

  Entity _owner;
  List<Entity> _entityPath = [];
}

abstract class Htmlable {
  // custom <class Htmlable>

  get html;

  // end <class Htmlable>

}

// custom <library entity>
// end <library entity>
