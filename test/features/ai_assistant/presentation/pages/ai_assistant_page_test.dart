import 'package:autask/app/app.dart';
import 'package:autask/app/di/injection.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/ai_assistant/data/datasources/ai_assistant_remote_datasource.dart';
import 'package:autask/features/ai_settings/domain/usecases/save_ai_key_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AI assistant sends prompt and shows response', (
    WidgetTester tester,
  ) async {
    await configureDependencies(
      useInMemoryTaskDataSource: true,
      useInMemoryAiKeyDataSource: true,
      aiAssistantRemoteDataSource: InMemoryAiAssistantRemoteDataSource(
        responseText: 'Ini draft task dari AI.',
      ),
    );

    await sl<SaveAiKeyUseCase>().call(apiKey: 'AIza_valid_key_1234567890');

    await tester.pumpWidget(const AutaskApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.aiAssistantNavLabel));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('ai_assistant_input')),
      'Buatkan tugas belajar Flutter',
    );
    await tester.tap(find.byKey(const Key('ai_assistant_send_button')));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Ini draft task dari AI.'), findsOneWidget);
  });
}
