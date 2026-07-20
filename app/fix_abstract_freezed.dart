import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('_model.dart'));
  
  for (var file in files) {
    var content = file.readAsStringSync();
    bool changed = false;
    
    // Check if the file has '@freezed'
    if (content.contains('@freezed')) {
      // Find the class definition that has 'with _$'
      final regex = RegExp(r'class ([A-Za-z0-9_]+) with _\$([A-Za-z0-9_]+)');
      if (regex.hasMatch(content)) {
        // Only replace if it doesn't already have 'abstract ' or 'sealed ' before 'class'
        // Let's just replace 'class ModelName with _$ModelName' with 'abstract class ModelName with _$ModelName'
        // First we check if it already has 'abstract class'
        if (!content.contains('abstract class') && !content.contains('sealed class')) {
          content = content.replaceAllMapped(regex, (match) {
            return 'abstract class ${match.group(1)} with _\$${match.group(2)}';
          });
          changed = true;
        }
      }
    }

    if (changed) {
      file.writeAsStringSync(content);
      print('Fixed abstract in ${file.path}');
    }
  }
}
