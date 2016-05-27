part of ebisu_ang.ebisu_ang;

class Directive extends AngEntity {
  String selector;
  List<String> providers = [];

  // custom <class Directive>

  Directive(id) : super(id);

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  // end <class Directive>

}

// custom <part ang_directive>
// end <part ang_directive>
