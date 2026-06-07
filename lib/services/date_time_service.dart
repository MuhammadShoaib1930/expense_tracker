class DateTimeService {
  static const List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  static const List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  static String dayName(DateTime dateTime) {
    return days[dateTime.weekday - 1];
  }

  static String monthName(DateTime dateTime) {
    return months[dateTime.month - 1];
  }

  static Map<String, int> dateToMap(DateTime dateTime) {
    return {
      "day": dateTime.day,
      "month": dateTime.month,
      "year": dateTime.year,
      "hour": dateTime.hour % 12,
      "minute": dateTime.minute,
    };
  }

  static List<String> dateTimeToString(DateTime dateTime) {
    Map<String, int> dt = dateToMap(dateTime);
    int day = dt['day']!;
    int month = dt['month']!;
    int hour = dt['hour']!;
    int minute = dt['minute']!;
    return [
      "Date: ${(day < 10) ? '0' : ''}$day:${(month < 10) ? '0' : ''}$month:${dt['year']}",
      "Time: ${(hour < 10) ? '0' : ''}$hour:${(minute < 10) ? '0' : ''}$minute",
    ];
  }
}
