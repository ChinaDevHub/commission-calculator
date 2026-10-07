import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('domain and the core it depends on import nothing from Flutter', () {
    final flutterImport = RegExp(r'''import\s+['"](package:flutter|dart:ui)''');
    const pureDirectories = ['/domain/', '/core/enums/', '/core/errors/'];

    final offenders = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => pureDirectories.any(file.path.contains))
        .where((file) => flutterImport.hasMatch(file.readAsStringSync()))
        .map((file) => file.path);

    expect(offenders, isEmpty);
  });
}
