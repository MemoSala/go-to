class NumDay {
  final int numper;
  final bool isMonth;
  NumDay(this.numper, this.isMonth);
}

class DateTimeDay {
  const DateTimeDay(this.year, this.month);
  final int year;
  final int month;
  List<NumDay> get time {
    int numMonth = month < 8
        ? month == 2
            ? year % 4 == 0
                ? 29
                : 28
            : month % 2 == 0
                ? 30
                : 31
        : month % 2 == 0
            ? 31
            : 30;
    int numYear = (year % 4 == 0 && month != 1) ? 366 : 365;
    int numDay = (numYear + _voidMonthDay + _voidYearDay) % 7;
    List<NumDay> listDays = [];
    for (var i = 0; i < numDay; i++) {
      int numOldMonth = month - 1 < 8
          ? month - 1 == 2
              ? year % 4 == 0
                  ? 29
                  : 28
              : month - 1 % 2 == 0
                  ? 30
                  : 31
          : month - 1 % 2 == 0
              ? 31
              : 30;
      listDays.add(NumDay(numOldMonth - numDay + i + 1, false));
    }
    for (var i = 0; i < numMonth; i++) {
      listDays.add(NumDay(i + 1, true));
    }
    for (var i = 0; i < (7 * 6) - (numMonth + numDay); i++) {
      listDays.add(NumDay(i + 1, false));
    }
    return listDays;
  }

  int get _voidMonthDay {
    int monthDay = 0;
    for (var i = 0; i < month - 1; i++) {
      monthDay += i + 1 < 8
          ? i + 1 == 2
              ? year % 4 == 0
                  ? 29
                  : 28
              : (i + 1) % 2 == 0
                  ? 30
                  : 31
          : (i + 1) % 2 == 0
              ? 31
              : 30;
    }
    return monthDay;
  }

  int get _voidYearDay => ((((year - 1) % 4) + ((year - 1) ~/ 4) * 5) - 1) % 7;
}
