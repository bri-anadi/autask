import 'package:autask/app/app.dart';
import 'package:autask/app/di/injection.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/ai_assistant/data/datasources/ai_assistant_remote_datasource.dart';
import 'package:autask/features/ai_settings/domain/usecases/save_ai_key_usecase.dart';
import 'package:flutter/material.dart';
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

  testWidgets('AI draft can be reviewed and saved into task list', (
    WidgetTester tester,
  ) async {
    await configureDependencies(
      useInMemoryTaskDataSource: true,
      useInMemoryAiKeyDataSource: true,
      aiAssistantRemoteDataSource: InMemoryAiAssistantRemoteDataSource(
        responseText:
            '{"title":"Belajar Flutter Bloc","description":"Pelajari cubit dan state","status":"todo","priority":"medium","due_date":"2026-04-20"}',
      ),
    );

    await sl<SaveAiKeyUseCase>().call(apiKey: 'AIza_valid_key_1234567890');

    await tester.pumpWidget(const AutaskApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.aiAssistantNavLabel));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('ai_assistant_input')),
      'Buatkan task belajar bloc',
    );
    await tester.tap(find.byKey(const Key('ai_assistant_send_button')));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.aiAssistantDraftReady), findsOneWidget);

    await tester.tap(find.byKey(const Key('ai_assistant_review_draft_button')));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.aiAssistantConfirmSheetTitle), findsOneWidget);

    await tester.tap(find.byKey(const Key('ai_assistant_save_draft_button')));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Belajar Flutter Bloc'), findsOneWidget);
  });

  testWidgets('AI fallback manual flow can save task into task list', (
    WidgetTester tester,
  ) async {
    await configureDependencies(
      useInMemoryTaskDataSource: true,
      useInMemoryAiKeyDataSource: true,
      aiAssistantRemoteDataSource: InMemoryAiAssistantRemoteDataSource(
        responseText: 'Tolong buat task presentasi final untuk minggu depan.',
      ),
    );

    await sl<SaveAiKeyUseCase>().call(apiKey: 'AIza_valid_key_1234567890');

    await tester.pumpWidget(const AutaskApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.aiAssistantNavLabel));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('ai_assistant_input')),
      'Buat task presentasi final',
    );
    await tester.tap(find.byKey(const Key('ai_assistant_send_button')));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.aiAssistantDraftFallback), findsOneWidget);

    await tester.tap(find.byKey(const Key('ai_assistant_manual_draft_button')));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.aiAssistantManualSheetTitle), findsOneWidget);
    expect(find.byKey(const Key('ai_assistant_sheet_title_input')), findsOneWidget);
    await tester.tap(find.byKey(const Key('ai_assistant_save_draft_button')));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Tolong buat task presentasi final'), findsWidgets);
  });
}
