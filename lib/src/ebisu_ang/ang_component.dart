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
  String template;

  // custom <class Component>

  Component(id)
      : super(id),
        meta = new ComponentMeta();

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
      _library = new Library(id);
    }
    return _library;
  }

  // end <class Component>

  Library _library;
}

class Controller {
  // custom <class Controller>
  // end <class Controller>

}

// custom <part ang_component>

component(id) => new Component(id);

// end <part ang_component>
