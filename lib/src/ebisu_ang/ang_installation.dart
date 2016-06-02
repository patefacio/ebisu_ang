part of ebisu_ang.ebisu_ang;

class Installation extends Entity {
  Installation(id, {this.rootPath, this.appComponent, components})
      : super(id),
        components = components ?? [] {
    // custom <Installation ctor>

    rootPath ??= dirname(dirname(absolute(Platform.script.toFilePath())));
    _index = new Index(this.id);

    // end <Installation ctor>
  }

  Index get index => _index;
  String rootPath;
  Component appComponent;
  List<Component> components = [];

  // custom <class Installation>

  toString() => ebisu.brCompact([
        'Installation(${this.id})',
        ebisu.indentBlock(ebisu.brCompact([components, appComponent]))
      ]);

  Iterable get children => concat([
        [appComponent],
        components
      ]);

  generate() {
    setRootNode();

    System ngSystem = system(id);

    final componentPath = join(rootPath, 'lib', 'components');

    concat([
      [appComponent],
      components
    ]).forEach((Component component) {
      ngSystem.libraries.add(component.library..path = componentPath);
      component.generateTemplate(componentPath);
    });

    final webPath = join(rootPath, 'web');

    ngSystem
      ..rootPath = rootPath
      ..libraries.add(library('main')
        ..path = webPath
        ..imports = [
          'package:angular2/angular2.dart',
          'package:angular2/platform/browser.dart',
          'package:${id.snake}/components/${appComponent.id.snake}.dart'
        ]
        ..mainCustomBlock.snippets.add('''
  bootstrap(${appComponent.controller.id.capCamel}, [
    // todo add providers
  ]);
        '''))
      ..pubSpec
          .pubTransformers
          .add(new AngTransformer(entryPoints: ['web/main.dart']))
      ..pubSpec.dependencies.addAll([
        new PubDependency('angular2')..version = '2.0.0-beta.17',
        new PubDependency('browser')..version = '^0.10.0',
      ])
      ..generate();

    ebisu.htmlMergeWithFile(index.html, join(webPath, 'index.html'));
  }

  // end <class Installation>

  Index _index;
}

// custom <part ang_installation>

installation(id) => new Installation(id);

// end <part ang_installation>
