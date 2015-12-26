part of ebisu_ang.ebisu_ang;

class ComponentMeta {
  String selector;

  /// For use when referring to separate file containing template
  String templateUrl;
  List<Directive> directives = [];
  List<String> styles = [];
  List<String> styleUrls = [];
  List<String> pipes = [];
  List<String> viewProviders = [];

  // custom <class ComponentMeta>

  toString() => brCompact([
        'Meta {',
        indentBlock(brCompact([
          '---- styles ----',
          styles,
          '---- styleUrls ----',
          styleUrls,
          '---- pipes ---',
          pipes,
          '---- veiwProviders ----',
          viewProviders
        ])),
        '}'
      ]);

  // end <class ComponentMeta>

}

class Component extends AngEntity {
  ComponentMeta meta;
  Class controller;
  List<Class> classes = [];
  Template template;

  // custom <class Component>

  Component(id)
      : super(id),
        meta = new ComponentMeta(),
        template = new Template(id) {
    controller = class_(id);
  }

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  toString() => brCompact([
        'Component(${id.snake})',
        indentBlock(meta.toString()),
        classes.isEmpty
            ? null
            : indentBlock(brCompact(
                ['---- Classes ----', classes.map((cls) => cls.className)]))
      ]);

  get library {
    if (_library == null) {
      controller.annotations = [
        annotation('''
@Component(
  selector: '${id.emacs}',
  templateUrl: '${id.snake}.html'
)
''')
      ];

      _library = new Library(id)
        ..imports.add('package:angular2/angular2.dart')
        ..classes.add(controller);
    }
    return _library;
  }

  // end <class Component>

  Library _library;
}

// custom <part ang_component>

component(id) => new Component(id);

// end <part ang_component>
