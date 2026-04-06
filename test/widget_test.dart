import 'package:autask/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App shows task page title', (WidgetTester tester) async {
    await tester.pumpWidget(const AutaskApp());

    expect(find.text('Daftar Tugas'), findsOneWidget);
    expect(
      find.text('Setup Minggu 2 selesai, lanjut minggu 3'),
      findsOneWidget,
    );
  });
}
