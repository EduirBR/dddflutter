import 'dart:io';
import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

void run(HookContext context) {
  final logger = context.logger;
  final pubspecPath = 'pubspec.yaml';
  final pubspecFile = File(pubspecPath);

  if (!pubspecFile.existsSync()) {
    logger.err('pubspec.yaml not found. Run this brick inside a Flutter project.');
    return;
  }

  final dependencies = <String, String>{
    'flutter_riverpod': '^3.3.1',
    'go_router': '^17.1.0',
    'flutter_secure_storage': '^10.0.0',
  };

  final content = pubspecFile.readAsStringSync();
  final yaml = loadYaml(content) as YamlMap;
  final deps = yaml['dependencies'] as YamlMap? ?? YamlMap();

  final missing = <String, String>{};
  for (final entry in dependencies.entries) {
    if (!deps.containsKey(entry.key)) {
      missing[entry.key] = entry.value;
    }
  }

  if (missing.isEmpty) {
    logger.info('All required dependencies are already present.');
  } else {
    final editor = YamlEditor(content);
    for (final entry in missing.entries) {
      editor.update(['dependencies', entry.key], entry.value);
      logger.info('Adding ${entry.key}: ${entry.value}');
    }

    pubspecFile.writeAsStringSync(editor.toString());
    logger.success('Dependencies added to pubspec.yaml');
  }

  final progress = logger.progress('Running flutter pub get...');
  try {
    final result = Process.runSync('flutter', ['pub', 'get']);
    if (result.exitCode == 0) {
      progress.complete();
      logger.success('Dependencies installed successfully!');
    } else {
      progress.fail();
      logger.err(result.stderr.toString());
    }
  } catch (e) {
    progress.fail();
    logger.err('Failed to run flutter pub get: $e');
  }
}
