import 'dart:developer';
import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

Future<void> main() async {
  const String linter = 'lint';
  const String linterVersion = '^2.3.0';

  const String includeOption = 'package:lint/strict.yaml';

  final Directory packageDir = Directory('packages');

  if (!await packageDir.exists()) {
    log('Directory "packages" does not exists.');
    return;
  }

  final List<File> files = await packageDir
      .list(recursive: true)
      .where(
        (entity) =>
            entity is File &&
            (entity.path.endsWith('pubspec.yaml') ||
                entity.path.endsWith('analysis_options.yaml')),
      )
      .cast<File>()
      .toList();

  for (final File file in files) {
    if (file.path.endsWith('pubspec.yaml')) {
      await _updateDevDependencies(
        file,
        package: linter,
        version: linterVersion,
      );
    } else if (file.path.endsWith('analysis_options.yaml')) {
      await _includeAnalysisOption(file, includeOption: includeOption);
    }
  }

  log('Linter update successfully');
}

Future<void> _updateDevDependencies(
  File pubspec, {
  required String package,
  required String version,
}) async {
  final String content = await pubspec.readAsString();
  final YamlMap doc = loadYaml(content) as YamlMap;
  final YamlEditor editor = YamlEditor(content);

  if (doc.containsKey('dev_dependencies')) {
    editor.update(['dev_dependencies', package], version);
  } else {
    editor.update(['dev_dependencies'], {package: version});
  }

  await pubspec.writeAsString(editor.toString());
  log('Updated linter version in ${pubspec.path}');
}

Future<void> _includeAnalysisOption(
  File analysisOption, {
  required String includeOption,
}) async {
  final StringBuffer content = StringBuffer(
    await analysisOption.readAsString(),
  );
  final YamlMap? doc = loadYaml(content.toString()) as YamlMap?;
  final YamlEditor editor = YamlEditor(content.toString());

  if (doc == null) {
    content.writeln('\ninclude: $includeOption');
    await analysisOption.writeAsString(content.toString());
    log('Updated analysis options package in ${analysisOption.path}');
    return;
  }

  if (doc.containsKey('include')) {
    editor.update(['include'], includeOption);
  } else {
    editor.appendToList(['include'], includeOption);
  }

  await analysisOption.writeAsString(editor.toString());
  log('Updated analysis options package in ${analysisOption.path}');
}
