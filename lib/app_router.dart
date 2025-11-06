import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:my_personal_app/views/home_page.dart';
import 'package:my_personal_app/views/detail_page.dart';
import 'package:my_personal_app/views/github_page.dart';
import 'package:my_personal_app/views/resume_builder_page.dart';
import 'package:my_personal_app/views/map_screen.dart'; // ✅ додай цей імпорт

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (BuildContext context, GoRouterState state) {
        final profileId = state.pathParameters['id']!;
        return DetailPage(profileId: profileId);
      },
    ),
    GoRoute(
      path: '/detail/duplicate/:id',
      builder: (BuildContext context, GoRouterState state) {
        final templateId = state.pathParameters['id']!;
        return DetailPage(profileId: templateId, isDuplicating: true);
      },
    ),
    GoRoute(
      path: '/github-stats',
      builder: (BuildContext context, GoRouterState state) {
        return const GitHubPage();
      },
    ),
    GoRoute(
      path: '/resume-builder',
      builder: (BuildContext context, GoRouterState state) {
        return const ResumeBuilderPage();
      },
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const MapScreen(),
    ),
  ],
);
