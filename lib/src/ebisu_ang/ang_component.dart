part of ebisu_ang.ebisu_ang;

class Component extends AngEntity {
  String selector;

  /// For use when referring to separate file containing template
  String templateUrl;

  /// For use when inlining template
  String template;
  List<Directive> directives = [];
  List<String> styles = [];
  List<String> styleUrls = [];
  List<String> pipes = [];
  List<String> viewProviders = [];

  // custom <class Component>

  Component(id) : super(id);

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  toString() => brCompact([
    'Component(${id.snake})',
    indentBlock(brCompact([
      '---- styles ---',
      styles,
      '---- styleUrls ---',
      styleUrls,
    ]))
  ]);

  // end <class Component>

}

class Controller {
  // custom <class Controller>
  // end <class Controller>

}

class View {
  Template template;
  List directives;

  // custom <class View>
  // end <class View>

}

// custom <part ang_component>

component(id) => new Component(id);

// end <part ang_component>
