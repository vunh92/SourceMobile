enum WeekdayEnum {
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY,
  SUNDAY,
}

extension HelperWeekdayEnum on WeekdayEnum {
  String name() {
    switch (this) {
      case WeekdayEnum.MONDAY:
        return "Thứ 2";
      case WeekdayEnum.TUESDAY:
        return "Thứ 3";
      case WeekdayEnum.WEDNESDAY:
        return "Thứ 4";
      case WeekdayEnum.THURSDAY:
        return "Thứ 5";
      case WeekdayEnum.FRIDAY:
        return "Thứ 6";
      case WeekdayEnum.SATURDAY:
        return "Thứ 7";
      case WeekdayEnum.SUNDAY:
        return "CN";
      default:
        return "";
    }
  }
}