import 'package:autask/app/app.dart';
import 'package:autask/app/di/injection.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/ai_assistant/data/datasources/ai_assistant_remote_datasource.dart';
import 'package:autask/features/ai_settings/domain/usecases/save_ai_key_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AI assistant sends prompt and shows fallback summary', (
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

    expect(find.text(AppStrings.aiAssistantFallbackMessage), findsOneWidget);
    expect(find.text('Ini draft task dari AI.'), findsNothing);
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

    expect(find.byKey(const Key('ai_assistant_draft_preview_card')), findsOneWidget);
    expect(find.text('Belajar Flutter Bloc'), findsOneWidget);
    expect(find.text(AppStrings.aiAssistantDraftParsedMessage), findsOneWidget);
    expect(
      find.text(
        '{"title":"Belajar Flutter Bloc","description":"Pelajari cubit dan state","status":"todo","priority":"medium","due_date":"2026-04-20"}',
      ),
      findsNothing,
    );

    await tester.tap(find.byKey(const Key('ai_assistant_save_preview_button')));
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

  testWidgets('AI assistant shows safe error message when request fails', (
    WidgetTester tester,
  ) async {
    await configureDependencies(
      useInMemoryTaskDataSource: true,
      useInMemoryAiKeyDataSource: true,
      aiAssistantRemoteDataSource: InMemoryAiAssistantRemoteDataSource(
        errorMessage: 'Permintaan AI melebihi batas waktu.',
      ),
    );

    await sl<SaveAiKeyUseCase>().call(apiKey: 'AIza_valid_key_1234567890');

    await tester.pumpWidget(const AutaskApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.aiAssistantNavLabel));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('ai_assistant_input')),
      'Buatkan task',
    );
    await tester.tap(find.byKey(const Key('ai_assistant_send_button')));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Permintaan AI melebihi batas waktu.'), findsOneWidget);
  });

  testWidgets('AI to task flow supports create update and delete scenario', (
    WidgetTester tester,
  ) async {
    await configureDependencies(
      useInMemoryTaskDataSource: true,
      useInMemoryAiKeyDataSource: true,
      aiAssistantRemoteDataSource: InMemoryAiAssistantRemoteDataSource(
        responseText:
            '{"title":"Review MVP","description":"Cek fitur inti sebelum demo","status":"todo","priority":"high","due_date":"2026-04-21"}',
      ),
    );

    await sl<SaveAiKeyUseCase>().call(apiKey: 'AIza_valid_key_1234567890');

    await tester.pumpWidget(const AutaskApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.aiAssistantNavLabel));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('ai_assistant_input')),
      'Buat task review mvp',
    );
    await tester.tap(find.byKey(const Key('ai_assistant_send_button')));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('ai_assistant_save_preview_button')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Review MVP'), findsOneWidget);
    expect(find.text('To Do'), findsOneWidget);

    await tester.tap(find.byTooltip(AppStrings.quickStatusLabel).first);
    await tester.pumpAndSettle();

    expect(find.text('In Progress'), findsOneWidget);

    await tester.drag(find.text('Review MVP'), const Offset(500, 0));
    await tester.pumpAndSettle();

    expect(find.text('Review MVP'), findsNothing);
    expect(find.text(AppStrings.emptyTaskMessage), findsOneWidget);
  });
}
