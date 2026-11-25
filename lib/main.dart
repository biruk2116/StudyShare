import 'package:material_ui/material_ui.dart';

import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const StudyShareApp());

class StudyShareApp extends StatelessWidget {
  const StudyShareApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'StudyShare',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    home: const LoginScreen(),
  );
}

// Retain the starter project's widget-test entry point while using the app's
// current name in production.
class MyApp extends StudyShareApp {
  const MyApp({super.key});
}
