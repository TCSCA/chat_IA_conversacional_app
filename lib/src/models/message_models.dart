class Message {
  final String text;
  final DateTime date;
  final bool isSendByMe;
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;

  const Message(
      {required this.text,
        required this.date,
        required this.isSendByMe,
        this.question1,
        this.question2,
        this.question3,
        this.question4,
        this.question5,
      });
}