part of ebisu_ang.ebisu_ang;

/// Index html file for a package
class Index {
  Index(this._id);

  Id get id => _id;

  // custom <class Index>

  get html => '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script type="application/dart" src="main.dart"></script>
    <script src="packages/browser/dart.js"></script>
  </head>
  <body>
    <${id.emacs}></${id.emacs}>
  </body>
</html>
''';

  // end <class Index>

  Id _id;
}

// custom <part ang_index>
// end <part ang_index>
