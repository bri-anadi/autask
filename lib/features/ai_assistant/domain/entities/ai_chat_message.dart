import 'package:equatable/equatable.dart';

enum AiChatRole { user, assistant }

class AiChatMessage extends Equatable {
  const AiChatMessage({
    required this.role,
    required this.text,
    required this.createdAt,
  });

  final AiChatRole role;
  final String text;
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[role, text, createdAt];
}
