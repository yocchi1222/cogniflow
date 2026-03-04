import 'package:go_router/go_router.dart';

import '../data/models/daily_session.dart';
import '../data/repositories/daily_repository.dart';
import '../features/history/history_detail_screen.dart';
import '../features/history/history_screen.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/result/result_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/test/test_flow_screen.dart';
import '../features/test/test_start_screen.dart';

GoRouter buildRouter(DailyRepository repository) {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(repository: repository),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(repository: repository),
      ),
      GoRoute(
        path: '/test-start',
        builder: (context, state) => TestStartScreen(repository: repository),
      ),
      GoRoute(
        path: '/test-flow',
        builder: (context, state) => TestFlowScreen(repository: repository),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) {
          final session = state.extra as DailySession;
          return ResultScreen(repository: repository, session: session);
        },
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => HistoryScreen(repository: repository),
      ),
      GoRoute(
        path: '/history-detail',
        builder: (context, state) {
          final session = state.extra as DailySession;
          return HistoryDetailScreen(repository: repository, session: session);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
