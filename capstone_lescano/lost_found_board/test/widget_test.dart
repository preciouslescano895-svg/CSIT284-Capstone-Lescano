
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lost_found_board/main.dart';

void main() {
  testWidgets('Shows Lost and Found Board feed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LostFoundApp());

    expect(find.text('Lost & Found Board'), findsOneWidget);
    expect(find.text('Black Wallet'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
