part of ebisu_ang.ebisu_ang;

class Package extends AngEntity {
  List<Component> components = [];

  // custom <class Package>

  Package(id) : super(id);

  Iterable<Entity> get children => components;

  toString() =>
      brCompact(['Package(${id.snake})', indentBlock(brCompact(components))]);

  generate() {
    print('Generating package $id -> ${owner.id}');
    final rootPath = owner.rootPath;
    final pkg = new System(id)
      ..rootPath = join(rootPath, 'pkg', id.snake)
      ..libraries.addAll(components.map((cmp) => cmp.library));

    pkg.generate();
  }

  // end <class Package>

}

// custom <part ang_package>

package(id) => new Package(id);

// end <part ang_package>
