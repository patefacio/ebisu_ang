part of ebisu_ang.ebisu_ang;

class Installation extends Entity {
  Installation(id, {this.index, this.rootPath, this.appComponent, components})
      : super(id),
        components = components ?? [] {
    // custom <Installation ctor>

    rootPath ??= dirname(dirname(absolute(Platform.script.toFilePath())));

    // end <Installation ctor>
  }

  Index index;
  String rootPath;
  Component appComponent;
  List<Component> components = [];

  // custom <class Installation>

  toString() => ebisu.brCompact([
        'Installation(${this.id})',
        ebisu.indentBlock(ebisu.brCompact([components, appComponent]))
      ]);

  generate() {
    System ngSystem = system(id);

    final componentPath = join(rootPath, 'lib', 'components');

    concat([
      [appComponent],
      components
    ]).forEach((Component component) {
      ngSystem.libraries.add(_makeLibrary(componentPath, component));
    });

    ngSystem
      ..rootPath = rootPath
      ..libraries.add(library('main')
        ..path = join(rootPath, 'web')
        ..mainCustomBlock.snippets.add('boo'))
      ..pubSpec
          .pubTransformers
          .add(new AngTransformer(entryPoints: ['web/main.dart']))
      ..pubSpec.dependencies.addAll([
        new PubDependency('angular2')..version = '2.0.0-beta.17',
        new PubDependency('browser')..version = '^0.10.0',
      ])
      ..generate();
  }

  _makeLibrary(path, Component component) => library(component.id)
    ..path = path
    ..classes = [class_(component.id)];

  // end <class Installation>

}

// custom <part ang_installation>

installation(id) => new Installation(id);

// end <part ang_installation>
