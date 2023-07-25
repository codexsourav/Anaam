import 'package:anaam/utils/getTime.dart';

class PostModel {
  PostModel({
    required this.id,
    required this.desc,
    required this.url,
  });
  final String url;
  final String id;
  final String desc;

  toJsonData() => {
        "id": id,
        "desc": desc,
        "url": url,
        "like": [],
        "time": getDateTime(date: DateTime.now()),
        "uploadtime": DateTime.now(),
      };
}
