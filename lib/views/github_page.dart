// views/github_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_personal_app/viewmodels/github_viewmodel.dart';
import 'package:my_personal_app/models/github_profile.dart';

class GitHubPage extends StatefulWidget {
  const GitHubPage({super.key});

  @override
  State<GitHubPage> createState() => _GitHubPageState();
}

class _GitHubPageState extends State<GitHubPage> {
  @override
  void initState() {
    super.initState();
    // Запускаємо завантаження даних при ініціалізації
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GitHubViewModel>(context, listen: false).loadGitHubProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GitHubViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("GitHub Статистика"),
      ),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(GitHubViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            viewModel.errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    if (viewModel.profile != null) {
      return _buildProfileCard(viewModel.profile!);
    }
    
    return const Center(child: Text("Натисніть кнопку для завантаження статистики."));
  }

  Widget _buildProfileCard(GitHubProfile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profile.avatarUrl),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Text(
                  profile.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Center(
                child: Text(
                  '@${profile.login}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey[600]),
                ),
              ),
              const Divider(height: 30),
              Text(
                'Біографія:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 5),
              Text(profile.bio),
              const Divider(height: 30),
              _buildStatsRow(
                'Репозиторії:',
                profile.publicRepos.toString(),
                Icons.storage,
              ),
              _buildStatsRow(
                'Підписники:',
                profile.followers.toString(),
                Icons.people,
              ),
              _buildStatsRow(
                'Підписаний на:',
                profile.following.toString(),
                Icons.favorite,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.link),
                  label: const Text("Відкрити на GitHub"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }
}