library ebisu_ang.view;

import 'package:ebisu/ebisu.dart' as ebisu;
import 'package:ebisu_ang/entity.dart';

// custom <additional imports>
// end <additional imports>

class Template {
  String get content => _content;

  // custom <class Template>

  get html => taggedHtml(null);

  taggedHtml(tag) => ebisu.brCompact([
        '<div>',
        tag != null ? '<em>generated component $tag</em>' : '',
        content,
        '</div>'
      ]);

  // end <class Template>

  String _content;
}

class View {
  Template get template => _template;

  // custom <class View>
  // end <class View>

  Template _template;
}

// custom <library view>
// end <library view>
