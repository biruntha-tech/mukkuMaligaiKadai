import 'package:flutter_test/flutter_test.dart';
import 'package:mukku_maligai_kadai/main.dart';

void main() {
  testWidgets('App loads and shows title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MukkuMaligaiApp());

    // Verify that the title exists.
    expect(find.text('Mukku Maligai Kadai'), findsAtLeastNWidgets(1));
  });
}
