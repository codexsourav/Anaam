import 'package:anaam/utils/getTime.dart';

class NotifyModel {
  NotifyModel({
    required this.uid,
    required this.text,
    required this.type,
    required this.ismsg,
  });
  final String uid;
  final String text;
  final String type;
  final bool ismsg;

  toJsonData() => {
        "uid": uid,
        "text": text,
        "time": getDateTime(date: DateTime.now(), formet: "d MMM"),
        "ismsg": ismsg,
        "type": type,
        "datetime": DateTime.now(),
      };
}
