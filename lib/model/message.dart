class Message {
  final String id;
  final String message;
  Message(this.message, this.id);
  factory Message.fromJosn(jsonData) {
    return Message(jsonData['message'], jsonData['id']);
  }
}
