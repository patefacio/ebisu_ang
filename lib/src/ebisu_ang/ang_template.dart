part of ebisu_ang.ebisu_ang;

class Template extends AngEntity {
  String content;

  // custom <class Template>

  Template(id, [this.content]) : super(id) {
    if (content == null) {
      content = '''
<div>
<em>generated component - ${id}</em>
${htmlCustomBlock(this.id.snake)}
</div>
''';
    }
  }

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  toString() => content;

  // end <class Template>

}

// custom <part ang_template>
// end <part ang_template>
