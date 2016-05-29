library ebisu_ang.component;

import 'entity.dart';
import 'package:ebisu/ebisu.dart' as ebisu;
import 'package:ebisu/ebisu_dart_meta.dart';
import 'package:ebisu_ang/directive.dart';

export 'entity.dart';

// custom <additional imports>
// end <additional imports>

class IoExpr {
  IoExpr(this._expr);

  String get expr => _expr;

  // custom <class IoExpr>

  get htmlAttrVal => ebisu.smartDoubleQuote(expr);

  // end <class IoExpr>

  String _expr;
}

class IExpr extends IoExpr {
  // custom <class IExpr>

  IExpr(expr) : super(expr);

  // end <class IExpr>

}

class OExpr extends IoExpr {
  // custom <class OExpr>

  OExpr(expr) : super(expr);

  // end <class OExpr>

}

class Input extends Identifiable implements Htmlable {
  Input(id, this._target, this._iExpr, [isHtmlClass])
      : super(id),
        _isHtmlClass = isHtmlClass ?? false;

  /// The right-hand side expression
  IExpr get iExpr => _iExpr;

  /// Used to specify classes as input configuration - (See *ng-book2* - *How Angular
  /// Works* - *search* "is a fun one")
  bool get isHtmlClass => _isHtmlClass;

  // custom <class Input>

  get expr => _iExpr;

  /// The target on the component, usually a component member, receiving the input
  get target => _isHtmlClass ? 'class.$_target' : _target;

  get html => '[$target]=${expr.htmlAttrVal}';

  // end <class Input>

  /// The target on the componen, usually a component member, receiving the input
  String _target;
  IExpr _iExpr;
  bool _isHtmlClass = false;
}

/// Create Input without new, for more declarative construction
Input input(id, String target, IExpr iExpr, [bool isHtmlClass]) =>
    new Input(id, target, iExpr, isHtmlClass);

class Output extends Identifiable implements Htmlable {
  Output(id, [this._event, this._action]) : super(id);

  String get event => _event;

  /// The right-hand side expression - which is the action performed *on the client*
  OExpr get action => _action;

  // custom <class Output>

  get expr => action;
  get html => '($_event)=${action.htmlAttrVal}';

  // end <class Output>

  String _event;
  OExpr _action;
}

/// Create Output without new, for more declarative construction
Output output(id, [String event, OExpr action]) =>
    new Output(id, event, action);

class ComponentAnnotation {
  ComponentAnnotation(
      {selector,
      templateUrl,
      directives,
      inputs,
      outputs,
      host,
      styles,
      styleUrls,
      pipes,
      viewProviders})
      : _selector = selector,
        _templateUrl = templateUrl,
        _directives = directives ?? [],
        _inputs = inputs ?? [],
        _outputs = outputs ?? [],
        _host = host ?? {},
        _styles = styles ?? [],
        _styleUrls = styleUrls ?? [],
        _pipes = pipes ?? [],
        _viewProviders = viewProviders ?? [];

  String get selector => _selector;

  /// For use when referring to separate file containing template
  String get templateUrl => _templateUrl;
  List<Directive> get directives => _directives;
  List<String> get inputs => _inputs;
  List<String> get outputs => _outputs;

  /// Enables setting attributes on the *host* element. (See *ng-book2* - *How Angular
  /// Works* - *search* "host option lets us set")
  Map get host => _host;
  List<String> get styles => _styles;
  List<String> get styleUrls => _styleUrls;
  List<String> get pipes => _pipes;
  List<String> get viewProviders => _viewProviders;

  // custom <class ComponentAnnotation>
  // end <class ComponentAnnotation>

  String _selector;
  String _templateUrl;
  List<Directive> _directives = [];
  List<String> _inputs = [];
  List<String> _outputs = [];
  Map _host = {};
  List<String> _styles = [];
  List<String> _styleUrls = [];
  List<String> _pipes = [];
  List<String> _viewProviders = [];
}

/// Create ComponentAnnotation without new, for more declarative construction
ComponentAnnotation componentAnnotation(
        {String selector,
        String templateUrl,
        List<Directive> directives,
        List<String> inputs,
        List<String> outputs,
        Map host,
        List<String> styles,
        List<String> styleUrls,
        List<String> pipes,
        List<String> viewProviders}) =>
    new ComponentAnnotation(
        selector: selector,
        templateUrl: templateUrl,
        directives: directives,
        inputs: inputs,
        outputs: outputs,
        host: host,
        styles: styles,
        styleUrls: styleUrls,
        pipes: pipes,
        viewProviders: viewProviders);

class Template {
  Template({content}) : _content = content;

  String get content => _content;

  // custom <class Template>
  // end <class Template>

  String _content;
}

class Component extends Entity {
  Component(id, {annotation, controller, classes, library, template})
      : super(id),
        _annotation = annotation,
        _controller = controller,
        _classes = classes ?? [],
        _library = library,
        _template = template;

  ComponentAnnotation get annotation => _annotation;
  Class get controller => _controller;
  List<Class> get classes => _classes;
  Template get template => _template;

  // custom <class Component>

  // end <class Component>

  ComponentAnnotation _annotation;
  Class _controller;
  List<Class> _classes = [];
  Library _library;
  Template _template;
}

/// Create Component without new, for more declarative construction
Component component(id,
        {ComponentAnnotation annotation,
        Class controller,
        List<Class> classes,
        Library library,
        Template template}) =>
    new Component(id,
        annotation: annotation,
        controller: controller,
        classes: classes,
        library: library,
        template: template);

// custom <library component>

IExpr iExpr(expr) => new IExpr(expr);
OExpr oExpr(expr) => new OExpr(expr);

// end <library component>
