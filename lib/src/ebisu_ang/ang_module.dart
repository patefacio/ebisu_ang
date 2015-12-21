part of ebisu_ang.ebisu_ang;

class Module extends AngEntity {
  List<Component> components = [];

  // custom <class Module>

  Module(id) : super(id);

  Iterable<Entity> get children => components;

  toString() => brCompact([
    'Module(${id.snake})',
    indentBlock(brCompact(components))
  ]);

  // end <class Module>

}

// custom <part ang_module>

module(id) => new Module(id);

// end <part ang_module>
