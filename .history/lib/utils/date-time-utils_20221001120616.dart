import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getFormatedDateTimeFromServerFormat(String createdAt) {
//    2020-05-30T07:49:19.461Z
    //String formattedDate = DateFormat("MMM dd, yyyy, hh:mm:ss aa").format(date.toLocal());
    // Ideal format : 2022-02-09T16:00:00.000Z

    createdAt = createdAt + 'Z';

    // DateTime parseDate = DateFormat("yyyy-MM-dd'T'hh:mm:ssZ").parse(createdAt);

    DateTime parseDate =
        DateFormat("yyyy-MM-dd hh:mm:ssZ").parse(givenDateTime);
    var inputDate = DateTime.parse(parseDate.toString()).toLocal();

    var outputFormat = DateFormat('MMM dd, yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate.toLocal());

    return outputDate;
  }

  static String getFormatedDateTime(DateTime createdAt) {
    if (createdAt == null) return "";
//    2020-05-30T07:49:19.461Z

    String formattedDate =
        DateFormat("MMM dd, yyyy, hh:mm:ss aa").format(createdAt.toLocal());

    return formattedDate;
  }

  static String getMMMDDYYYFromServerFormat(String createdAt) {
    if (createdAt == null) return "";
//    2020-05-30T07:49:19.461Z

    String dateString = createdAt.split("T")[0];
    var date = DateFormat("yyyy-mm-dd").parse(dateString);
    String formattedDate = DateFormat("MMM dd, yyyy").format(date.toLocal());

    return formattedDate;
  }

  static String getMMMDDYYY(DateTime dt) {
    if (dt == null) return "";
    return DateFormat("MMM dd, yyyy").format(dt.toLocal());
  }

  static String getAMPM(DateTime dt) {
    if (dt == null) return "";
    return DateFormat("a").format(dt.toLocal());
  }

  static String getYesterday() {
    final now = DateTime.now()..subtract(Duration(days: 1));
//    final lastMidnight = new DateTime(now.year, now.month, now.day);

    String formattedDate = DateFormat("dd MMM, yyyy").format(now);

    return formattedDate;
  }
}
