part of ebisu_ang.ebisu_ang;

class Module extends AngEntity {
  // custom <class Module>

  Module(id) : super(id);

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  // end <class Module>

}

// custom <part ang_module>

module(id) => new Module(id);

// end <part ang_module>
