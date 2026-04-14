import 'package:autask/features/ai_assistant/domain/entities/ai_chat_message.dart';
import 'package:equatable/equatable.dart';

enum AiAssistantStatus { initial, loading, loaded, error }

class AiAssistantState extends Equatable {
  static const Object _unset = Object();

  const AiAssistantState({
    required this.status,
    required this.messages,
    required this.message,
  });

  final AiAssistantStatus status;
  final List<AiChatMessage> messages;
  final String? message;

  const AiAssistantState.initial()
    : this(
        status: AiAssistantStatus.initial,
        messages: const <AiChatMessage>[],
        message: null,
      );

  AiAssistantState copyWith({
    AiAssistantStatus? status,
    List<AiChatMessage>? messages,
    Object? message = _unset,
  }) {
    return AiAssistantState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      message: message == _unset ? this.message : message as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, messages, message];
}
