import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_poetry/app.dart';

void main() {
  testWidgets('PoetryApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PoetryApp(),
      ),
    );

    // Advance past the SplashPage 2-second auto-navigation timer.
    await tester.pump(const Duration(seconds: 3));

    // Verify the app renders without errors.
    expect(find.byType(ProviderScope), findsOneWidget);
  });
}
