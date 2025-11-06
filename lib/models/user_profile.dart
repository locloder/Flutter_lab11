class UserProfile {
  final String id;
  final String name;
  final String title;
  final String bio;
  final List<String> skills;
  final String email;

  UserProfile({
    required this.id,
    required this.name,
    required this.title,
    required this.bio,
    required this.skills,
    required this.email,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? title,
    String? bio,
    List<String>? skills,
    String? email,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      email: email ?? this.email,
    );
  }

  static UserProfile createEmpty() {
    return UserProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Використовуємо унікальний ID
      name: 'Нове Резюме',
      title: 'Ваша Посада',
      bio: 'Тут буде ваше резюме...',
      skills: ['Flutter', 'Dart'],
      email: 'your.email@example.com',
    );
  }


  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'title': title,
    'bio': bio,
    'skills': skills,
    'email': email,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      bio: json['bio'] as String,
      skills: List<String>.from(json['skills'] as List),
      email: json['email'] as String,
    );
  }
}