import 'package:intl/intl.dart';

class TimeUtils{

  static String getTime(String timestamp){
    final dateTime = DateTime.parse(timestamp);
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }
}
