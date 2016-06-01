library ebisu_ang.component;

import 'directive.dart';
import 'entity.dart';
import 'package:ebisu/ebisu.dart' as ebisu;
import 'package:ebisu/ebisu_dart_meta.dart' as ebisu_dart_meta;
import 'package:ebisu_ang/directive.dart';
import 'package:id/id.dart';
import 'view.dart';

export 'entity.dart';
export 'view.dart';
export 'directive.dart';

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

class Component extends Entity {
  Component(id,
      {this.selector,
      this.template,
      this.templateUrl,
      directives,
      inputs,
      outputs,
      host,
      styles,
      styleUrls,
      pipes,
      viewProviders})
      : super(ebisu.makeId(id)),
        directives = directives ?? [],
        inputs = inputs ?? [],
        outputs = outputs ?? [],
        host = host ?? {},
        styles = styles ?? [],
        styleUrls = styleUrls ?? [],
        pipes = pipes ?? [],
        viewProviders = viewProviders ?? [] {
    // custom <Component Ctor>

    selector ??= this.id.emacs;
    _controller = ebisu_dart_meta.class_(this.id);
    _library = ebisu_dart_meta.library(this.id)
      ..classes = [_controller]
      ..imports.add('package:angular2/angular2.dart');

    // end <Component Ctor>
  }

  String selector;
  Template template;

  /// For use when referring to separate file containing template
  String templateUrl;
  List<Directive> directives = [];
  List<String> inputs = [];
  List<String> outputs = [];

  /// Enables setting attributes on the *host* element. (See *ng-book2* - *How Angular
  /// Works* - *search* "host option lets us set")
  Map host = {};
  List<String> styles = [];
  List<String> styleUrls = [];
  List<String> pipes = [];
  List<String> viewProviders = [];
  ebisu_dart_meta.Class get controller => _controller;
  ebisu_dart_meta.Library get library => _library;

  // custom <class Component>

  get tag => this.id.emacs;

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  onOwnershipEstablished() {
    _hardenAnnotations();
  }

  _hardenAnnotations() {
    _controller.annotations.add(ebisu_dart_meta.annotation(
        ebisu.brCompact(['@Component (',
        /// selector for the component
        "selector: '$selector'",
        /// close out the component annotation
            ')'])));
  }

  // end <class Component>

  ebisu_dart_meta.Class _controller;
  ebisu_dart_meta.Library _library;
}

/// Create Component without new, for more declarative construction
Component component(id,
        {String selector,
        Template template,
        String templateUrl,
        List<Directive> directives,
        List<String> inputs,
        List<String> outputs,
        Map host,
        List<String> styles,
        List<String> styleUrls,
        List<String> pipes,
        List<String> viewProviders}) =>
    new Component(id,
        selector: selector,
        template: template,
        templateUrl: templateUrl,
        directives: directives,
        inputs: inputs,
        outputs: outputs,
        host: host,
        styles: styles,
        styleUrls: styleUrls,
        pipes: pipes,
        viewProviders: viewProviders);

// custom <library component>

IExpr iExpr(expr) => new IExpr(expr);
OExpr oExpr(expr) => new OExpr(expr);

// end <library component>
