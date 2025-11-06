import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_personal_app/models/github_profile.dart';

class GitHubRepository {
  final String baseUrl = 'https://api.github.com/users/';

  Future<GitHubProfile> fetchUserProfile(String username) async {
    final response = await http.get(Uri.parse('$baseUrl$username'));

    if (response.statusCode == 200) {
      return GitHubProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load GitHub profile for $username. Status code: ${response.statusCode}');
    }
  }
}