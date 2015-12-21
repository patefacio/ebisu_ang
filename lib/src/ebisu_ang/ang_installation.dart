part of ebisu_ang.ebisu_ang;

class Installation extends AngEntity {
  List<App> apps = [];
  List<Modules> modules = [];

  // custom <class Installation>

  Installation(id) : super(id);

  Iterable<Entity> get children => concat([apps, modules]);

  // end <class Installation>

}

// custom <part ang_installation>

installation(id) => new Installation(id);

// end <part ang_installation>
