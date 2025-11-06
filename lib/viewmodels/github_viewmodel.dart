import 'package:flutter/material.dart';
import 'package:my_personal_app/models/github_profile.dart';
import 'package:my_personal_app/models/repositories/github_repository.dart';

class GitHubViewModel extends ChangeNotifier {
  final GitHubRepository _repository;
  GitHubProfile? _profile;
  bool _isLoading = false;
  String? _errorMessage;

  GitHubViewModel({required GitHubRepository repository}) : _repository = repository;

  GitHubProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  static const String _githubUsername = "locloder";

  Future<void> loadGitHubProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _profile = await _repository.fetchUserProfile(_githubUsername);
    } catch (e) {
      _errorMessage = 'Не вдалося завантажити дані. Перевірте підключення або ім\'я користувача. Помилка: ${e.toString()}';
      _profile = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}