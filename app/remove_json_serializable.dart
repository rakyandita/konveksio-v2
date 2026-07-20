import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('_model.dart'));
  
  for (var file in files) {
    var content = file.readAsStringSync();
    bool changed = false;
    
    // Remove ignore line
    if (content.contains('// ignore: invalid_annotation_target\n')) {
      content = content.replaceAll('// ignore: invalid_annotation_target\n', '');
      changed = true;
    }
    if (content.contains('    // ignore: invalid_annotation_target\n')) {
      content = content.replaceAll('    // ignore: invalid_annotation_target\n', '');
      changed = true;
    }
    
    // Remove @JsonSerializable line
    if (content.contains('@JsonSerializable(fieldRename: FieldRename.snake)\n')) {
      content = content.replaceAll('@JsonSerializable(fieldRename: FieldRename.snake)\n', '');
      changed = true;
    }
    if (content.contains('  @JsonSerializable(fieldRename: FieldRename.snake)\n')) {
      content = content.replaceAll('  @JsonSerializable(fieldRename: FieldRename.snake)\n', '');
      changed = true;
    }

    if (changed) {
      file.writeAsStringSync(content);
      print('Cleaned ${file.path}');
    }
  }
}
