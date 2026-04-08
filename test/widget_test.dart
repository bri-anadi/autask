import 'package:autask/app/app.dart';
import 'package:autask/app/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App shows task page title', (WidgetTester tester) async {
    await configureDependencies(
      useInMemoryTaskDataSource: true,
      useInMemoryAiKeyDataSource: true,
    );

    await tester.pumpWidget(const AutaskApp());

    expect(find.text('Daftar Tugas'), findsWidgets);
    expect(find.text('Cari tugas...'), findsOneWidget);
  });
}
