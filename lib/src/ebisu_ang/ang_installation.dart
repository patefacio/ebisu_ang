part of ebisu_ang.ebisu_ang;

class Installation extends AngEntity {
  List<App> apps = [];
  List<Package> packages = [];

  // custom <class Installation>

  Installation(id) : super(id);

  Iterable<Entity> get children => concat([apps, packages]);

  set rootPath(String rootPath) => _rootPath = rootPath;

  get rootPath {
    if (_rootPath == null) {
      _rootPath = dirname(Platform.script.path);
    }
    return _rootPath;
  }

  toString() => brCompact([
        'Installation(${this.id})',
        indentBlock(brCompact([packages, apps]))
      ]);

  generate() {
    setAsRoot();
    packages.forEach((pkg) => pkg.generate());
  }

  // end <class Installation>

  String _rootPath;
}

// custom <part ang_installation>

installation(id) => new Installation(id);

// end <part ang_installation>
