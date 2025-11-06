import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:my_personal_app/app_router.dart';
import 'package:my_personal_app/viewmodels/home_viewmodel.dart';
import 'package:my_personal_app/viewmodels/detail_viewmodel.dart';
import 'package:my_personal_app/viewmodels/github_viewmodel.dart';
import 'package:my_personal_app/models/repositories/user_profile_repository.dart';
import 'package:my_personal_app/models/repositories/github_repository.dart';
import 'package:my_personal_app/services/local_storage_service.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    await MobileAds.instance.initialize();
  }

  final localStorageService = LocalStorageService();
  final userProfileRepository = UserProfileRepository(
    localStorageService: localStorageService,
  );

  await userProfileRepository.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<UserProfileRepository>(create: (_) => userProfileRepository),
        ChangeNotifierProvider(
          create: (context) =>
              HomeViewModel(repository: userProfileRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailViewModel(
            repository:
                Provider.of<UserProfileRepository>(context, listen: false),
          ),
        ),
        Provider<GitHubRepository>(create: (_) => GitHubRepository()),
        ChangeNotifierProvider(
          create: (context) => GitHubViewModel(
            repository:
                Provider.of<GitHubRepository>(context, listen: false),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Мій Особистий Додаток',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: appRouter,
    );
  }
}
