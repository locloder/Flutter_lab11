import 'package:my_personal_app/models/user_profile.dart';
import 'package:my_personal_app/services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

class UserProfileRepository {
  List<UserProfile> _userProfiles = [];

  final LocalStorageService _localStorageService;

  final Uuid _uuid = const Uuid();

  UserProfileRepository({LocalStorageService? localStorageService})
      : _localStorageService = localStorageService ?? LocalStorageService();


  Future<void> initialize() async {
    _userProfiles = await _localStorageService.loadResumes();

    if (_userProfiles.isEmpty) {
      final starterProfile = UserProfile.createEmpty().copyWith(
        id: _uuid.v4(),
      );
      _userProfiles.add(starterProfile);
      _saveData();
    }
  }


  List<UserProfile> getAllProfiles() {
    return List.unmodifiable(_userProfiles);
  }

  UserProfile? getProfileById(String id) {
    return _userProfiles.firstWhereOrNull((profile) => profile.id == id);
  }

  void addProfile(UserProfile profile) {
    final newProfile = profile.copyWith(id: _uuid.v4());
    _userProfiles.add(newProfile);
    _saveData();
  }

  void updateProfile(UserProfile updatedProfile) {
    final index = _userProfiles.indexWhere((p) => p.id == updatedProfile.id);
    if (index != -1) {
      _userProfiles[index] = updatedProfile;
      _saveData();
    }
  }

  void deleteProfile(String id) {
    _userProfiles.removeWhere((p) => p.id == id);
    _saveData();
  }


  void _saveData() {
    _localStorageService.saveResumes(_userProfiles);
  }
}