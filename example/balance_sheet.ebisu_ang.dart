import 'package:ebisu_ang/ebisu_ang.dart';
import 'package:ebisu/ebisu.dart';

main() {

  final dossier =
    installation('dossier')
    ..packages = [
      package('balance_sheet')
      ..components = [
        component('account'),
      ]
    ];

  print(dossier);

  dossier.generate();
}