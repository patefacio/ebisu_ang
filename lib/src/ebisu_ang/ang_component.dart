part of ebisu_ang.ebisu_ang;

class Component {
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
// end <part ang_component>
