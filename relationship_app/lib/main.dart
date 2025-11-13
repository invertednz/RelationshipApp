import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/models/journal_entry.dart';
import 'core/models/user_profile.dart';
import 'core/models/garden_session.dart';
import 'data/repositories/user_repository.dart';
import 'data/repositories/journal_repository.dart';
import 'data/repositories/garden_repository.dart';
import 'providers/app_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters
  Hive.registerAdapter(JournalEntryAdapter());
  Hive.registerAdapter(JournalSpaceAdapter());
  Hive.registerAdapter(MoodAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(GardenSessionAdapter());
  Hive.registerAdapter(GardenProgressAdapter());
  
  // Initialize repositories
  final userRepository = UserRepository();
  final journalRepository = JournalRepository();
  final gardenRepository = GardenRepository();
  
  await userRepository.initialize();
  await journalRepository.initialize();
  await gardenRepository.initialize();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(ProviderScope(
    overrides: [
      userRepositoryProvider.overrideWithValue(userRepository),
      journalRepositoryProvider.overrideWithValue(journalRepository),
      gardenRepositoryProvider.overrideWithValue(gardenRepository),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Relationship App',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
