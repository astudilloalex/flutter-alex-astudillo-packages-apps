import 'dart:developer';
import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

Future<void> main() async {
  const String sdkVersion = '>=3.1.0 <4.0.0';
  final Directory packageDir = Directory('packages');

  if (!await packageDir.exists()) {
    log('Directory "packages" does not exists.');
    return;
  }

  final List<File> files = await packageDir
      .list(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('pubspec.yaml'))
      .cast<File>()
      .toList();

  for (final File file in files) {
    await _updateSDKVersion(file, sdkVersion);
  }

  log('SDK version update successfully');
}

Future<void> _updateSDKVersion(File pubspec, String sdkVersion) async {
  final String content = await pubspec.readAsString();
  final YamlMap doc = loadYaml(content) as YamlMap;
  final YamlEditor editor = YamlEditor(content);

  if (doc.containsKey('environment')) {
    editor.update(['environment', 'sdk'], sdkVersion);
  } else {
    editor.update(['environment'], {'sdk': sdkVersion});
  }

  await pubspec.writeAsString(editor.toString());
  log('Updated SDK version in ${pubspec.path}');
}
