import 'package:equatable/equatable.dart';

enum AiSettingsStatus { initial, loading, loaded, success, error }

class AiSettingsState extends Equatable {
  static const Object _unset = Object();

  const AiSettingsState({
    required this.status,
    required this.hasSavedKey,
    required this.maskedKey,
    required this.isKeyVisible,
    required this.message,
  });

  final AiSettingsStatus status;
  final bool hasSavedKey;
  final String? maskedKey;
  final bool isKeyVisible;
  final String? message;

  const AiSettingsState.initial()
    : this(
        status: AiSettingsStatus.initial,
        hasSavedKey: false,
        maskedKey: null,
        isKeyVisible: false,
        message: null,
      );

  AiSettingsState copyWith({
    AiSettingsStatus? status,
    bool? hasSavedKey,
    Object? maskedKey = _unset,
    bool? isKeyVisible,
    Object? message = _unset,
  }) {
    return AiSettingsState(
      status: status ?? this.status,
      hasSavedKey: hasSavedKey ?? this.hasSavedKey,
      maskedKey: maskedKey == _unset ? this.maskedKey : maskedKey as String?,
      isKeyVisible: isKeyVisible ?? this.isKeyVisible,
      message: message == _unset ? this.message : message as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    hasSavedKey,
    maskedKey,
    isKeyVisible,
    message,
  ];
}
