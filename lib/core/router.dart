import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/widgets/scaffold.dart';
import '../features/home/home_view.dart';
import '../features/search/search_view.dart';
import '../features/detail/detail_view.dart';
import '../features/player/player_view.dart';
import '../features/download/download_view.dart';
import '../features/favorites/favorites_view.dart';
import '../features/history/history_view.dart';
import '../features/settings/settings_view.dart';
import '../features/category/category_view.dart';
import '../features/source_feed/source_feed_view.dart';
import '../features/forest/forest_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeView(),
          ),
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SearchView(),
          ),
        ),
        GoRoute(
          path: '/forest',
          name: 'forest',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ForestView(),
          ),
        ),
        GoRoute(
          path: '/detail/:sourceName/:videoId',
          name: 'detail',
          builder: (context, state) => DetailView(
            sourceName: state.pathParameters['sourceName']!,
            videoId: state.pathParameters['videoId']!,
          ),
        ),
        GoRoute(
          path: '/category/:sourceName',
          name: 'category',
          builder: (context, state) => CategoryView(
            sourceName: state.pathParameters['sourceName']!,
            categoryName: state.uri.queryParameters['name'] ?? '',
          ),
        ),
        GoRoute(
          path: '/source-feed/:sourceName',
          name: 'source-feed',
          builder: (context, state) => SourceFeedView(
            sourceName: state.pathParameters['sourceName']!,
          ),
        ),
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: FavoritesView(),
          ),
        ),
        GoRoute(
          path: '/history',
          name: 'history',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HistoryView(),
          ),
        ),
        GoRoute(
          path: '/downloads',
          name: 'downloads',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DownloadView(),
          ),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsView(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/player',
      name: 'player',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return PlayerView(
          sourceName: extra['sourceName'] ?? '',
          videoId: extra['videoId'] ?? '',
          episodeIndex: extra['episodeIndex'] ?? 0,
          sourceIndex: extra['sourceIndex'] ?? 0,
          title: extra['title'] ?? '',
          resumeFrom: extra['resumeFrom'] ?? 0.0,
          localPath: extra['localPath'],
        );
      },
    ),
  ],
);
