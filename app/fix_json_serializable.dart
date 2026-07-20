import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('_model.dart'));
  
  for (var file in files) {
    var content = file.readAsStringSync();
    if (content.contains('@JsonSerializable') && !content.contains('ignore: invalid_annotation_target')) {
      content = content.replaceAll(
          '  @JsonSerializable',
          '  // ignore: invalid_annotation_target\n  @JsonSerializable');
      file.writeAsStringSync(content);
      print('Fixed ${file.path}');
    }
  }
}
