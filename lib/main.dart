import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/application/auth_controller.dart';
import 'features/auth/data/auth_repository.dart';

void main() => runApp(const StudyShareApp());

class StudyShareApp extends StatelessWidget {
  const StudyShareApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => AuthController(AuthRepository()),
    child: MaterialApp.router(
      title: 'StudyShare',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    ),
  );
}

// Keep the original starter entry point available to downstream callers.
class MyApp extends StudyShareApp {
  const MyApp({super.key});
}
