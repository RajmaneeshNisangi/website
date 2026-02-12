import 'package:flutter_test/flutter_test.dart';
import 'package:website/main.dart';

void main() {
  testWidgets('App renders navbar title', (WidgetTester tester) async {
    await tester.pumpWidget(const CricketTournamentWebApp());
    await tester.pumpAndSettle();

    expect(find.text('Cricket Cup'), findsOneWidget);
  });
}
