class ChatMessage {
  int id;
  String messageType;
  String content;
  DateTime createdAt;
  ChatMessage({
    required this.id,
    required this.messageType,
    required this.content,
    required this.createdAt,
  });

  ChatMessage.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        messageType: map['messageType'],
        content: map['content'],
        createdAt: DateTime.parse(map['createdAt']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messageType': messageType,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
