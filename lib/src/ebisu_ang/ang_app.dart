part of ebisu_ang.ebisu_ang;

class App extends AngEntity {
  List<String> entryPoints = [];

  // custom <class App>

  App(id) : super(id);

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  // end <class App>

}

// custom <part ang_app>

app(id) => new App(id);

// end <part ang_app>
