import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_culture_generale/main.dart';

void main() {
  testWidgets("L'écran d'accueil affiche le titre et le bouton Démarrer",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Quiz Culture\nGénérale'), findsOneWidget);
    expect(find.text('Démarrer'), findsOneWidget);
  });
}
