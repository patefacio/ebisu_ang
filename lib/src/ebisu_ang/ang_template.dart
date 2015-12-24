part of ebisu_ang.ebisu_ang;

class Template extends AngEntity {
  String content;

  // custom <class Template>

  Template(id, [this.content]) : super(id) {
    if (content == null) {
      content = '''
<div>
${htmlCustomBlock(this.id.snake)}
</div>
''';
    }
  }

  toString() => content;

  // end <class Template>

}

// custom <part ang_template>
// end <part ang_template>
