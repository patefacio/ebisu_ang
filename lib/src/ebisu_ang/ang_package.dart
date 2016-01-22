part of ebisu_ang.ebisu_ang;

/// Index html file for a package
class Index extends AngEntity {
  String content;

  // custom <class Index>
  // end <class Index>

}

class Package extends AngEntity {
  List<Component> components = [];
  set appComponent(Component appComponent) => _appComponent = appComponent;
  Index get index => _index;

  // custom <class Package>

  Package(id) : super(id);

  Iterable<Entity> get children => components;

  toString() =>
      brCompact(['Package(${id.snake})', indentBlock(brCompact(components))]);

  get path =>
      _path == null ? (_path = join(owner.rootPath, 'pkg', id.snake)) : _path;

  generate() {
    _logger.info('Generating $this');

    final pkg = new System(id)
      ..rootPath = path
      ..libraries.addAll(components.map((cmp) => cmp.library));

    if (appComponent != null) {
      pkg.libraries.add(appComponent.library);
    }

    _logger.info(brCompact([
      'Generating package $id -> ${owner.id} with libs(${pkg.libraries.length}):',
      indentBlock(brCompact(pkg.libraries.map((l) => l.id.snake))),
    ]));

    components.forEach(_makeComponent);
    if (_appComponent != null) {
      _makeComponent(_appComponent);
    }

    pkg.generate();

    final webPath = join(path, 'web');
    main.path = webPath;
    if (_appComponent != null) {
      main
        ..imports.addAll(
            ['package:angular2/bootstrap.dart', appComponent.library.asImport,])
        ..libMain =
            'main([List<String> args]) => bootstrap(${appComponent.controller.name});';
    }

    main.generate();
  }

  get main => _main == null ? (_main = library('main')) : _main;

  get appComponent => _appComponent == null
      ? (_appComponent = component(id.snake + '_app'))
      : _appComponent;

  _makeComponent(Component component) => htmlMergeWithFile(
      component.template.toString(),
      join(path, 'lib', '${component.id.snake}.html'));

  // end <class Package>

  String _path;
  Component _appComponent;
  Library _main;
  Index _index;
}

// custom <part ang_package>

package(id) => new Package(id);

// end <part ang_package>
