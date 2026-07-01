import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_p3/main.dart';

void main() {
  testWidgets('L\'accueil affiche les 3 parties', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Activité 1 : CRUD sqflite'), findsOneWidget);
    expect(find.text('Activité 2 : Navigation'), findsOneWidget);
    expect(find.text('Projet : ChatBot ChatGPT'), findsOneWidget);
  });
}
