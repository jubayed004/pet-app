import 'package:intl/intl.dart';

class DateConverter {
  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }


  // Method to format the date from a string
  static String formatDate(dynamic dateStr, {String format = 'MMM dd, yyyy'}) {
    try {
      // Ensure the dateStr is converted to a String
      String dateString = dateStr.toString();  // Cast to String
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(dateString);
      // Use the intl package to format the DateTime into the desired string format
      return DateFormat(format).format(dateTime);
    } catch (e) {
      // Handle any parsing errors or invalid date strings
      print('Error formatting date: $e');
      return 'Invalid date';
    }
  }

  static String calender(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString()}";
  }

  /// Existing method to estimate the date string, if applicable
  static String estimateCalender(DateTime date) {
    // Your existing implementation here (if needed)
    return formatDate(date); // Call formatDate if you want the same format
  }

  // Method to estimate or modify dates (example purpose)
  static String estimatedDates(dynamic dateStr) {
    return formatDate(dateStr);
  }




  static DateTime convertStringToDatetime() {
    DateTime now = DateTime.now();
    return now.toUtc();
  }

  ///=============== Calculate Time of Day ===============

  static String getTimePeriod() {
    int currentHour = DateTime.now().hour;
    int morningBoundary = 6;
    int noonBoundary = 12;
    int eveningBoundary = 18;
    if (currentHour >= morningBoundary && currentHour < noonBoundary) {
      return "Good Morning";
    } else if (currentHour >= noonBoundary && currentHour < eveningBoundary) {
      return "Good Noon";
    } else {
      return "Good Evening";
    }
  }
}