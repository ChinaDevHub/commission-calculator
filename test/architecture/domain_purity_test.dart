import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Iterable<String> _filesImporting(RegExp import, List<String> directories) =>
    Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => directories.any(file.path.contains))
        .where((file) => import.hasMatch(file.readAsStringSync()))
        .map((file) => file.path);

void main() {
  test('domain and the core it depends on import nothing from Flutter', () {
    final flutterImport = RegExp(r'''import\s+['"](package:flutter|dart:ui)''');
    const pureDirectories = ['/domain/', '/core/enums/', '/core/errors/'];

    expect(_filesImporting(flutterImport, pureDirectories), isEmpty);
  });

  test('domain does not depend on the data or presentation layers', () {
    final outerLayerImport = RegExp(
      r'''import\s+['"]package:commission_calculator/features/\w+/(data|presentation)/''',
    );

    expect(_filesImporting(outerLayerImport, ['/domain/']), isEmpty);
  });

  test('data layer imports no Flutter UI libraries', () {
    final flutterUiImport = RegExp(
      r'''import\s+['"](package:flutter/(material|widgets|cupertino)|dart:ui)''',
    );

    expect(_filesImporting(flutterUiImport, ['/data/']), isEmpty);
  });
}
