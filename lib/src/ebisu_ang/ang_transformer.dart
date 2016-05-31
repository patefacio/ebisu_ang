part of ebisu_ang.ebisu_ang;

class AngTransformer extends PubTransformer {
  List<String> entryPoints = [];

  // custom <class AngTransformer>
  AngTransformer({entryPoints})
      : super('angular2'),
        entryPoints = entryPoints ?? [];

  String get yamlEntry => '''
- angular2:
    entry_points:
${ebisu.indentBlock(ebisu.brCompact(entryPoints.map((ep) => "- $ep")), '      ')}
''';
  // end <class AngTransformer>

}

// custom <part ang_transformer>
// end <part ang_transformer>
