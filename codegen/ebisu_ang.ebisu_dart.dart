#!/usr/bin/env dart
import 'dart:io';
import 'package:args/args.dart';
import 'package:ebisu/ebisu.dart';
import 'package:ebisu/ebisu_dart_meta.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';

// custom <additional imports>
// end <additional imports>
final _logger = new Logger('ebisuAngEbisuDart');

main(List<String> args) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
  useDartFormatter = true;
  String here = absolute(Platform.script.toFilePath());
  // custom <ebisuAngEbisuDart main>

  final purpose = '''
A library that supports code generation of Angular2 code
''';

  String _topDir = dirname(dirname(here));
  useDartFormatter = true;
  System ebisu = system('ebisu_ang')
    ..includesHop = true
    ..license = 'boost'
    ..pubSpec.homepage = 'https://github.com/patefacio/ebisu_ang'
    ..pubSpec.version = '0.0.1'
    ..pubSpec.doc = purpose
    ..rootPath = _topDir
    ..doc = purpose
    ..testLibraries = [library('test_component'), library('test_entity'),]
    ..libraries = [
      library('entity')
      ..includesLogger = true
        ..imports = [
          'package:id/id.dart',
          "'package:ebisu/ebisu.dart' as ebisu"
        ]
        ..classes = [
          class_('identifiable')
            ..isAbstract = false
            ..defaultCtorStyle = requiredParms
            ..members = [
              member('id')
                ..doc = 'Id for the [Identifiable]'
                ..access = RO
                ..type = 'Id',
            ],
          class_('entity')
            ..isAbstract = true
            ..hasJsonToString = false
            ..withDefaultCtor((ctor) => ctor
              ..frontParms = ['id']
              ..superArgs = ['ebisu.makeId(id)'])
            ..extend = 'Identifiable'
            ..members = [
              member('doc')..doc = 'Documentation for the angular entity',
              member('owner')..type = 'Entity'..access = RO,
              member('entity_path')..type = 'List<Entity>'
                ..access = RO..init = [],
            ],
          class_('htmlable')..isAbstract = true,
        ],
      library('view')
        ..imports = ['package:ebisu_ang/entity.dart']
        ..defaultMemberAccess = RO
        ..classes = [
          class_('template')..members = [member('content'),],
          class_('view')..members = [member('template')..type = 'Template',]
        ],
      library('directive')
        ..imports = ['package:ebisu_ang/entity.dart']
        ..defaultMemberAccess = RO
        ..classes = [
          class_('directive')
            ..withDefaultCtor((ctor) => ctor
              ..frontParms = ['id']
              ..superArgs = ['id'])
            ..extend = 'Entity'
            ..hasJsonToString = false
            ..members = [
              member('selector'),
              member('providers')
                ..type = 'List<String>'
                ..init = [],
            ]
        ],
      library('component')
        ..defaultMemberAccess = RO
        ..imports.addAll([
          "'package:ebisu/ebisu.dart' as ebisu",
          "'package:ebisu/ebisu_dart_meta.dart' as ebisu_dart_meta",
          'package:ebisu_ang/directive.dart',
          'package:id/id.dart',
        ])
        ..importAndExportAll(['entity.dart', 'view.dart', 'directive.dart'])
        ..classes = [
          class_('io_expr')
            ..defaultCtorStyle = requiredParms
            ..members = [member('expr'),],
          class_('i_expr')..extend = 'IoExpr',
          class_('o_expr')..extend = 'IoExpr',
          class_('input')
            ..extend = 'Identifiable'
            ..implement = ['Htmlable',]
            ..withDefaultCtor((ctor) => ctor
              ..superArgs = ['id']
              ..frontParms = ['id'])
            ..hasCtorSansNew = true
            ..members = [
              member('target')
                ..doc =
                    'The target on the componen, usually a component member, receiving the input'
                ..access = IA
                ..ctors = [''],
              member('i_expr')
                ..ctors = ['']
                ..type = 'IExpr'
                ..doc = 'The right-hand side expression',
              member('is_html_class')
                ..doc = '''
Used to specify classes as input configuration - (See *ng-book2* - *How Angular
Works* - *search* "is a fun one")
'''
                ..ctorsOpt = ['']
                ..init = false,
            ],
          class_('output')
            ..extend = 'Identifiable'
            ..implement = ['Htmlable',]
            ..withDefaultCtor((ctor) => ctor
              ..superArgs = ['id']
              ..frontParms = ['id'])
            ..hasCtorSansNew = true
            ..members = [
              member('event')..ctorsOpt = [''],
              member('action')
                ..ctorsOpt = ['']
                ..type = 'OExpr'
                ..doc =
                    'The right-hand side expression - which is the action performed *on the client*',
            ],
          class_('component')
            ..defaultCtorStyle = namedParms
            ..defaultMemberAccess = RW
            ..withDefaultCtor((Ctor ctor) => ctor
              ..frontParms = ['id']
              ..superArgs = ['ebisu.makeId(id)']
              ..tag = 'Component Ctor'
            )
            ..extend = 'Entity'
            ..hasCtorSansNew = true
            ..members = [
              member('selector'),
              member('template')..type = 'Template',
              member('directives')
                ..type = 'List<Directive>'
                ..init = [],
              member('inputs')
                ..type = 'List<String>'
                ..init = [],
              member('outputs')
                ..type = 'List<String>'
                ..init = [],
              member('host')
                ..doc = '''
Enables setting attributes on the *host* element. (See *ng-book2* - *How Angular
Works* - *search* "host option lets us set")'''
                ..type = 'Map'
                ..init = {},
              member('styles')
                ..type = 'List<String>'
                ..init = []..access = RW,
              member('style_urls')
                ..type = 'List<String>'
                ..init = [],
              member('pipes')
                ..type = 'List<String>'
                ..init = [],
              member('view_providers')
                ..type = 'List<String>'
                ..init = [],
              member('controller')
                ..access = RO
                ..type = 'ebisu_dart_meta.Class'
                ..isInDefaultCtor = false,
              member('library')
                ..type = 'ebisu_dart_meta.Library'
                ..access = RO
                ..isInDefaultCtor = false,
              member('has_inline_template')
                ..init = false,
            ],
        ],
      library('ebisu_ang')
        ..includesLogger = true
        ..imports = [
          'package:ebisu_ang/entity.dart',
          'package:id/id.dart',
          "'package:ebisu/ebisu.dart' as ebisu",
          "'package:ebisu/ebisu_dart_meta.dart' hide id",
          'package:quiver/iterables.dart',
          'package:path/path.dart',
          'io',
        ]
        ..importAndExport('package:ebisu_ang/component.dart')
        ..parts = [
          part('ang_installation')
            ..classes = [
              class_('installation')
                ..extend = 'Entity'
                ..defaultCtorStyle = namedParms
                ..withDefaultCtor((ctor) => ctor..frontParms = [ 'id']..superArgs = ['id']..tag = 'Installation ctor')
                ..members = [
                  member('index')..type = 'Index'..access = RO..isInDefaultCtor = false,
                  member('root_path')..access = RW,
                  member('app_component')..type = 'Component',
                  member('components')
                    ..type = 'List<Component>'
                    ..init = [],
                ]
            ],
          part('ang_index')
            ..classes = [
              class_('index')
                ..doc = 'Index html file for a package'
                ..defaultCtorStyle = requiredParms
                ..members = [
                  member('id')..type = 'Id'..access = RO,
                ],
            ],
          part('ang_transformer')
            ..classes = [
              class_('ang_transformer')
                ..extend = 'PubTransformer'
                ..members = [
                  member('entry_points')
                    ..type = 'List<String>'
                    ..init = [],
                ],
            ],
        ]
    ];

  ebisu.generate();

  print('''
**** NON GENERATED FILES ****
${indentBlock(brCompact(nonGeneratedFiles))}
''');

  // end <ebisuAngEbisuDart main>
}

// custom <ebisuAngEbisuDart global>
// end <ebisuAngEbisuDart global>
