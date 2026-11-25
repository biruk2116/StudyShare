import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:studyshare_app/main.dart';

void main() {
  testWidgets('auth screens render and navigate at a compact phone size', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Continue with Google'), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();
    expect(find.text('Send Reset Link'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'student@example.edu');
    await tester.ensureVisible(find.text('Send Reset Link'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Send Reset Link'));
    await tester.pumpAndSettle();
    expect(find.textContaining('No email has been sent.'), findsOneWidget);
    await tester.tap(find.text('Back to Login'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Create Account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create Account'));
    await tester.pumpAndSettle();

    expect(find.text('Join StudyShare'), findsOneWidget);
    expect(find.text('Department'), findsOneWidget);
    expect(find.text('Academic Year'), findsOneWidget);
    expect(find.text('Terms and Conditions'), findsOneWidget);
    expect(find.text('Confirm Password'), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });
}
