import 'package:ebisu_ang/ebisu_ang.dart';
import 'package:ebisu/ebisu.dart';

main() {

  final dossier =
    installation('dossier')
    ..modules = [
      module('balance_sheet')
      ..components = [
        component('account'),
      ]
    ];

  print(dossier);

}