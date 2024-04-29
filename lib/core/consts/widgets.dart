import 'package:intl/intl.dart';

getDateFormat(String date) {
  var convertedToDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(date);
  return getMonth(convertedToDate, nameLength: 3) + " ${convertedToDate.month}, ${convertedToDate.year}";
}

getTimeFormat(String date) {
  var convertedToDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(date);
  return DateFormat("HH:mm").format(convertedToDate);
}

getMonth(DateTime date, {int nameLength = 3}) {
  if (date.month == 1) {
    return "January".substring(0, nameLength);
  } else if (date.month == 2) {
    return "February".substring(0, nameLength);
  } else if (date.month == 3) {
    return "March".substring(0, nameLength);
  } else if (date.month == 4) {
    return "April".substring(0, nameLength);
  } else if (date.month == 5) {
    return "May".substring(0, nameLength);
  } else if (date.month == 6) {
    return "June".substring(0, nameLength);
  } else if (date.month == 7) {
    return "July".substring(0, nameLength);
  } else if (date.month == 8) {
    return "August".substring(0, nameLength);
  } else if (date.month == 9) {
    return "September".substring(0, nameLength);
  } else if (date.month == 10) {
    return "October".substring(0, nameLength);
  } else if (date.month == 11) {
    return "November".substring(0, nameLength);
  } else if (date.month == 12) {
    return "December".substring(0, nameLength);
  }
}
