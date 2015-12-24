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
  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
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
    ..testLibraries = [
    ]
    ..libraries = [

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
              member('apps')..type = 'List<App>'..classInit = [],
              member('packages')..type = 'List<Package>'..classInit = [],
            ]
          ],

          part('ang_app')
          ..classes = [
            class_('app')
            ..extend = 'AngEntity'
            ..members = [
              member('entry_points')..type = 'List<String>'..classInit = [],
            ],
          ],

          part('ang_entity')
          ..classes = [
            class_('ang_entity')
            ..mixins = [ 'Entity' ]
            ..isAbstract = true
            ..members = [ member('id')..type = 'Id' ]
          ],

          part('ang_template')
          ..classes = [
            class_('template')
            ..extend = 'AngEntity'
            ..members = [
              member('content'),
            ],
          ],

          part('ang_directive')
          ..classes = [
            class_('directive')
            ..extend = 'AngEntity'
            ..members = [
              member('selector'),
              member('providers')..type = 'List<String>'..classInit = [],
            ]
          ],

          part('ang_model')
          ..classes = [
            class_('model')
          ],

          part('ang_package')
          ..classes = [
            class_('package')
            ..extend = 'AngEntity'
            ..members = [
              member('components')..type = 'List<Component>'..classInit = [],
            ]
          ],

          part('ang_component')
          ..classes = [

            class_('component_meta')
            ..members = [
              member('selector'),
              member('template_url')
              ..doc = 'For use when referring to separate file containing template',
              member('directives')..type = 'List<Directive>'..classInit = [],
              member('styles')..type = 'List<String>'..classInit = [],
              member('style_urls')..type = 'List<String>'..classInit = [],
              member('pipes')..type = 'List<String>'..classInit = [],
              member('view_providers')..type = 'List<String>'..classInit = [],
            ],

            class_('component')
            ..extend = 'AngEntity'
            ..members = [
              member('meta')..type = 'ComponentMeta',
              member('controller')..type = 'Class',
              member('classes')..type = 'List<Class>'..classInit = [],
              member('library')..type = 'Library'..access = IA,
              member('template')..type = 'Template',
            ],
          ]


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
