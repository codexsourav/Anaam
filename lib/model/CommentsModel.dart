import '../utils/getTime.dart';

class CommentModel {
  CommentModel({
    required this.id,
    required this.text,
  });

  final String id;
  final String text;

  toJsonData() => {
        "id": id,
        "text": text,
        "time": getDateTime(date: DateTime.now()),
      };
}
