import 'package:intl/intl.dart';

class TimeUtils{

  static String getTime(DateTime timestamp){
    final formattedDate = DateFormat('dd/MM/yyyy').format(timestamp);
    return formattedDate;
  }
}
