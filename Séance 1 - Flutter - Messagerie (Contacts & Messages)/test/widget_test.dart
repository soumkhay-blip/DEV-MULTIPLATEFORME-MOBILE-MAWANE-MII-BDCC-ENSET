import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:contacts_app/main.dart';

void main() {
  testWidgets('La page de connexion s\'affiche au démarrage',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Contacts App'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
