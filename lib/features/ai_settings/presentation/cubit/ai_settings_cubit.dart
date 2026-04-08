import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/ai_settings/domain/usecases/delete_ai_key_usecase.dart';
import 'package:autask/features/ai_settings/domain/usecases/read_ai_key_usecase.dart';
import 'package:autask/features/ai_settings/domain/usecases/save_ai_key_usecase.dart';
import 'package:autask/features/ai_settings/presentation/cubit/ai_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiSettingsCubit extends Cubit<AiSettingsState> {
  AiSettingsCubit({
    required ReadAiKeyUseCase readAiKeyUseCase,
    required SaveAiKeyUseCase saveAiKeyUseCase,
    required DeleteAiKeyUseCase deleteAiKeyUseCase,
  }) : _readAiKeyUseCase = readAiKeyUseCase,
       _saveAiKeyUseCase = saveAiKeyUseCase,
       _deleteAiKeyUseCase = deleteAiKeyUseCase,
       super(const AiSettingsState.initial());

  final ReadAiKeyUseCase _readAiKeyUseCase;
  final SaveAiKeyUseCase _saveAiKeyUseCase;
  final DeleteAiKeyUseCase _deleteAiKeyUseCase;

  Future<void> loadSavedKey() async {
    emit(state.copyWith(status: AiSettingsStatus.loading, message: null));
    try {
      final String? savedKey = await _readAiKeyUseCase();
      emit(
        state.copyWith(
          status: AiSettingsStatus.loaded,
          hasSavedKey: savedKey != null && savedKey.isNotEmpty,
          maskedKey: savedKey == null || savedKey.isEmpty
              ? null
              : _maskKey(apiKey: savedKey),
          message: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AiSettingsStatus.error,
          message: AppStrings.aiLoadKeyError,
        ),
      );
    }
  }

  Future<void> saveApiKey({required String apiKey}) async {
    final String sanitizedKey = apiKey.trim();
    final String? errorMessage = _validateApiKey(apiKey: sanitizedKey);
    if (errorMessage != null) {
      emit(
        state.copyWith(status: AiSettingsStatus.error, message: errorMessage),
      );
      return;
    }

    emit(state.copyWith(status: AiSettingsStatus.loading, message: null));
    try {
      await _saveAiKeyUseCase(apiKey: sanitizedKey);
      emit(
        state.copyWith(
          status: AiSettingsStatus.success,
          hasSavedKey: true,
          maskedKey: _maskKey(apiKey: sanitizedKey),
          message: AppStrings.aiSaveKeySuccess,
        ),
      );
      emit(state.copyWith(status: AiSettingsStatus.loaded, message: null));
    } catch (_) {
      emit(
        state.copyWith(
          status: AiSettingsStatus.error,
          message: AppStrings.aiSaveKeyError,
        ),
      );
    }
  }

  Future<void> deleteApiKey() async {
    emit(state.copyWith(status: AiSettingsStatus.loading, message: null));
    try {
      await _deleteAiKeyUseCase();
      emit(
        state.copyWith(
          status: AiSettingsStatus.success,
          hasSavedKey: false,
          maskedKey: null,
          message: AppStrings.aiDeleteKeySuccess,
        ),
      );
      emit(state.copyWith(status: AiSettingsStatus.loaded, message: null));
    } catch (_) {
      emit(
        state.copyWith(
          status: AiSettingsStatus.error,
          message: AppStrings.aiDeleteKeyError,
        ),
      );
    }
  }

  void toggleKeyVisibility() {
    emit(
      state.copyWith(
        status: AiSettingsStatus.loaded,
        isKeyVisible: !state.isKeyVisible,
        message: null,
      ),
    );
  }

  String? _validateApiKey({required String apiKey}) {
    if (apiKey.isEmpty) {
      return AppStrings.aiValidationEmptyKey;
    }

    if (apiKey.contains(' ')) {
      return AppStrings.aiValidationNoSpaces;
    }

    if (apiKey.length < 20) {
      return AppStrings.aiValidationMinimumLength;
    }

    if (!apiKey.startsWith('AIza')) {
      return AppStrings.aiValidationPrefix;
    }

    return null;
  }

  String _maskKey({required String apiKey}) {
    if (apiKey.length <= 8) {
      return '*' * apiKey.length;
    }

    final String start = apiKey.substring(0, 4);
    final String end = apiKey.substring(apiKey.length - 4);
    final String middleMask = '*' * (apiKey.length - 8);
    return '$start$middleMask$end';
  }
}
