import 'package:intl/intl.dart';

getDateTime({required DateTime date, formet = 'MMM d, yyyy'}) {
  // Format the date.
  DateFormat formatter = DateFormat(formet);
  String formattedDate = formatter.format(date);

  // Print the date.
  return (formattedDate);
}
