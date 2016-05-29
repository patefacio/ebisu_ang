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
        ..imports = ['package:id/id.dart']
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
            ..hasJsonToString = false
            ..withDefaultCtor((ctor) => ctor..frontParms = ['id']..superArgs = ['id'])
            ..extend = 'Identifiable',
          class_('htmlable')
            ..isAbstract = true,
        ],
      library('directive')
      ..imports = [ 'package:ebisu_ang/entity.dart']
        ..defaultMemberAccess = RO
        ..classes = [
          class_('directive')
          ..withDefaultCtor((ctor) => ctor..frontParms = ['id']..superArgs = ['id'])
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
        'package:ebisu/ebisu_dart_meta.dart',
        'package:ebisu_ang/directive.dart'
        ])
        ..importAndExport('entity.dart')
        ..classes = [
          class_('io_expr')
            ..defaultCtorStyle = requiredParms
            ..members = [member('expr'),],
          class_('i_expr')..extend = 'IoExpr',
          class_('o_expr')..extend = 'IoExpr',
          class_('input')
            ..extend = 'Identifiable'
            ..implement = ['Htmlable', ]
            ..withDefaultCtor((ctor) => ctor..superArgs = ['id']..frontParms = ['id'])
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
            ..implement = ['Htmlable', ]
            ..withDefaultCtor((ctor) => ctor..superArgs = ['id']..frontParms = ['id'])
            ..hasCtorSansNew = true
            ..members = [
              member('event')..ctorsOpt = [''],
              member('action')
                ..ctorsOpt = ['']
                ..type = 'OExpr'
                ..doc =
                    'The right-hand side expression - which is the action performed *on the client*',
            ],
          class_('component_annotation')
            ..defaultCtorStyle = namedParms
            ..hasCtorSansNew = true
            ..hasJsonToString = false
            ..members = [
              member('selector'),
              member('template_url')
                ..doc =
                    'For use when referring to separate file containing template',
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
                ..init = [],
              member('style_urls')
                ..type = 'List<String>'
                ..init = [],
              member('pipes')
                ..type = 'List<String>'
                ..init = [],
              member('view_providers')
                ..type = 'List<String>'
                ..init = [],
            ],
          class_('template')
            ..defaultCtorStyle = namedParms
            ..members = [member('content'),],
          class_('component')
          ..withDefaultCtor((Ctor ctor) => ctor..frontParms = ['id']..superArgs = ['id'])
            ..defaultCtorStyle = namedParms
            ..extend = 'Entity'
            ..hasCtorSansNew = true
            ..members = [
              member('annotation')..type = 'ComponentAnnotation',
              member('controller')..type = 'Class',
              member('classes')
                ..type = 'List<Class>'
                ..init = [],
              member('library')
                ..type = 'Library'
                ..access = IA,
              member('template')..type = 'Template',
            ],
        ],
      library('ebisu_ang')
        ..includesLogger = true
        ..imports = [
          'package:id/id.dart',
          'package:ebisu/ebisu.dart',
          "'package:ebisu/ebisu_dart_meta.dart' hide id",
          'package:quiver/iterables.dart',
          'package:path/path.dart',
          'io',
        ]
        ..parts = [
          part('ang_installation')
            ..classes = [
              class_('installation')
                ..extend = 'AngEntity'
                ..members = [
                  member('root_path')..access = IA,
                  member('apps')
                    ..type = 'List<App>'
                    ..init = [],
                  member('packages')
                    ..type = 'List<Package>'
                    ..init = [],
                ]
            ],
          part('ang_app')
            ..classes = [
              class_('app')
                ..extend = 'AngEntity'
                ..members = [
                  member('entry_points')
                    ..type = 'List<String>'
                    ..init = [],
                ],
            ],
          part('ang_entity')
            ..classes = [
              class_('ang_entity')
                ..mixins = ['Entity']
                ..isAbstract = true
                ..members = [member('id')..type = 'Id']
            ],
          part('ang_template')
            ..classes = [
              class_('template')
                ..extend = 'AngEntity'
                ..members = [member('content'),],
            ],
          part('ang_directive')
            ..classes = [
              class_('directive')
                ..extend = 'AngEntity'
                ..members = [
                  member('selector'),
                  member('providers')
                    ..type = 'List<String>'
                    ..init = [],
                ]
            ],
          part('ang_model')..classes = [class_('model')],
          part('ang_package')
            ..classes = [
              class_('index')
                ..extend = 'AngEntity'
                ..doc = 'Index html file for a package'
                ..members = [member('content'),],
              class_('ang_transformer')
                ..extend = 'PubTransformer'
                ..members = [
                  member('entry_points')
                    ..type = 'List<String>'
                    ..init = [],
                ],
              class_('package')
                ..extend = 'AngEntity'
                ..members = [
                  member('path')..access = IA,
                  member('components')
                    ..type = 'List<Component>'
                    ..init = [],
                  member('app_component')
                    ..type = 'Component'
                    ..access = WO,
                  member('main')
                    ..type = 'Library'
                    ..access = IA,
                  member('index')
                    ..type = 'Index'
                    ..access = RO,
                ]
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
