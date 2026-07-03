import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_p3/main.dart';

void main() {
  testWidgets('L\'écran de connexion s\'affiche au démarrage',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
  });
}
