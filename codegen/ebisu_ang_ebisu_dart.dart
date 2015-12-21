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
          'package:quiver/iterables.dart',
        ]
        ..parts = [

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
            ..mixins = [ 'Entity' ]
            ..members = [
            ],
          ],

          part('ang_directive')
          ..classes = [],

          part('ang_model')
          ..classes = [
            class_('model')
          ],

          part('ang_module')
          ..classes = [
            class_('module')
          ],

          part('ang_component')
          ..classes = [
            class_('component')
            ..members = [
              member('selector')
            ],
            class_('controller'),

            class_('view')
            ..members = [
              member('template')..type = 'Template',
              member('directives')..type = 'List',
            ],
          ]


        ]
    ];


  ebisu.generate();

  _logger.warning('''
**** NON GENERATED FILES ****
${indentBlock(brCompact(nonGeneratedFiles))}
''');

  // end <ebisuAngEbisuDart main>
}

// custom <ebisuAngEbisuDart global>
// end <ebisuAngEbisuDart global>
