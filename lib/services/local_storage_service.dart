
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/user_profile.dart';

class LocalStorageService {
  static const String _fileName = 'resumes_data.json';

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/$_fileName');
  }

  Future<void> saveResumes(List<UserProfile> resumes) async {
    try {
      final file = await _localFile;

      final List<Map<String, dynamic>> jsonList =
          resumes.map((resume) => resume.toJson()).toList();
      
      final String jsonString = jsonEncode(jsonList);

      await file.writeAsString(jsonString);
      print('✅ Резюме успішно збережено у файл: ${file.path}');
    } catch (e) {
      print('❌ Помилка при збереженні резюме: $e');
    }
  }

  Future<List<UserProfile>> loadResumes() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        print('Файл збережених резюме не знайдено, повертаємо порожній список.');
        return [];
      }

      final String contents = await file.readAsString();
      
      final List<dynamic> jsonList = jsonDecode(contents);

      final List<UserProfile> resumes =
          jsonList.map((json) => UserProfile.fromJson(json as Map<String, dynamic>)).toList();

      print('✅ Резюме успішно завантажено: ${resumes.length} шт.');
      return resumes;

    } catch (e) {
      print('❌ Помилка при завантаженні резюме: $e');
      return [];
    }
  }
}