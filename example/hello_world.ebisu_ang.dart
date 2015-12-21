import 'package:ebisu_ang/ebisu_ang.dart';
import 'package:ebisu/ebisu.dart';

main() {

  final helloWorld =
    installation('hello_world')
    ..modules = [
      module('hello_mod'),
    ];

  for(var x in helloWorld.progeny) {
    print(x);
  }

}