library ebisu_ang.component;

import 'dart:convert' as convert;
import 'entity.dart';
import 'package:ebisu/ebisu.dart' as ebisu;

export 'entity.dart';

// custom <additional imports>
// end <additional imports>

class ComponentAnnotation {
  ComponentAnnotation(
      {selector,
      templateUrl,
      directives,
      styles,
      styleUrls,
      pipes,
      viewProviders})
      : _selector = selector,
        _templateUrl = templateUrl,
        _directives = directives ?? [],
        _styles = styles ?? [],
        _styleUrls = styleUrls ?? [],
        _pipes = pipes ?? [],
        _viewProviders = viewProviders ?? [];

  String get selector => _selector;

  /// For use when referring to separate file containing template
  String get templateUrl => _templateUrl;
  List<Directive> get directives => _directives;
  List<String> get styles => _styles;
  List<String> get styleUrls => _styleUrls;
  List<String> get pipes => _pipes;
  List<String> get viewProviders => _viewProviders;

  // custom <class ComponentAnnotation>
  // end <class ComponentAnnotation>

  toString() => '(${runtimeType}) => ${ebisu.prettyJsonMap(toJson())}';

  Map toJson() => {
        "selector": ebisu.toJson(selector),
        "templateUrl": ebisu.toJson(templateUrl),
        "directives": ebisu.toJson(directives),
        "styles": ebisu.toJson(styles),
        "styleUrls": ebisu.toJson(styleUrls),
        "pipes": ebisu.toJson(pipes),
        "viewProviders": ebisu.toJson(viewProviders),
      };

  static ComponentAnnotation fromJson(Object json) {
    if (json == null) return null;
    if (json is String) {
      json = convert.JSON.decode(json);
    }
    assert(json is Map);
    return new ComponentAnnotation._fromJsonMapImpl(json);
  }

  ComponentAnnotation._fromJsonMapImpl(Map jsonMap)
      : _selector = jsonMap["selector"],
        _templateUrl = jsonMap["templateUrl"],
        // directives is List<Directive>
        _directives = ebisu.constructListFromJsonData(
            jsonMap["directives"], (data) => Directive.fromJson(data)),
        // styles is List<String>
        _styles =
            ebisu.constructListFromJsonData(jsonMap["styles"], (data) => data),
        // styleUrls is List<String>
        _styleUrls = ebisu.constructListFromJsonData(
            jsonMap["styleUrls"], (data) => data),
        // pipes is List<String>
        _pipes =
            ebisu.constructListFromJsonData(jsonMap["pipes"], (data) => data),
        // viewProviders is List<String>
        _viewProviders = ebisu.constructListFromJsonData(
            jsonMap["viewProviders"], (data) => data);

  ComponentAnnotation._copy(ComponentAnnotation other)
      : _selector = other._selector,
        _templateUrl = other._templateUrl,
        _directives = other._directives == null
            ? null
            : (new List.from(
                other._directives.map((e) => e == null ? null : e.copy()))),
        _styles = other._styles == null ? null : new List.from(other._styles),
        _styleUrls =
            other._styleUrls == null ? null : new List.from(other._styleUrls),
        _pipes = other._pipes == null ? null : new List.from(other._pipes),
        _viewProviders = other._viewProviders == null
            ? null
            : new List.from(other._viewProviders);

  String _selector;
  String _templateUrl;
  List<Directive> _directives = [];
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
        List<String> styles,
        List<String> styleUrls,
        List<String> pipes,
        List<String> viewProviders}) =>
    new ComponentAnnotation(
        selector: selector,
        templateUrl: templateUrl,
        directives: directives,
        styles: styles,
        styleUrls: styleUrls,
        pipes: pipes,
        viewProviders: viewProviders);

class Input extends Object with Identifiable {
  String get target => _target;

  // custom <class Input>
  // end <class Input>

  String _target;
}

class Output extends Object with Identifiable {
  String get handler => _handler;

  // custom <class Output>
  // end <class Output>

  String _handler;
}

class Template {
  Template({content}) : _content = content;

  String get content => _content;

  // custom <class Template>
  // end <class Template>

  String _content;
}

class Component extends Object with Entity {
  Component({annotation, controller, classes, library, template})
      : _annotation = annotation,
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

// custom <library component>
// end <library component>
