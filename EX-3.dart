
class MyDuration {
  final int _milliseconds;

  MyDuration._(this._milliseconds) {
    if (_milliseconds < 0) {
      throw Exception('Duration cannot be negative!');
    }
  }

  MyDuration.fromHours(int hours)
      : this._(hours * 60 * 60 * 1000);

  MyDuration.fromMinutes(int minutes)
      : this._(minutes * 60 * 1000);

  MyDuration.fromSeconds(int seconds)
      : this._(seconds * 1000);

  int get milliseconds => _milliseconds;

  bool operator >(MyDuration other) {
    return _milliseconds > other._milliseconds;
  }

  MyDuration operator +(MyDuration other) {
    return MyDuration._(
      _milliseconds + other._milliseconds,
    );
  }

  MyDuration operator -(MyDuration other) {
    if (_milliseconds < other._milliseconds) {
      throw Exception('Duration cannot be negative!');
    }

    return MyDuration._(
      _milliseconds - other._milliseconds,
    );
  }

  @override
  String toString() {
    int seconds = _milliseconds ~/ 1000;
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;

    int hours = minutes ~/ 60;
    minutes = minutes % 60;

    return '$hours hours, $minutes minutes, $seconds seconds';
  }
}

void main() {
  MyDuration duration1 = MyDuration.fromHours(3);
  MyDuration duration2 = MyDuration.fromMinutes(45);
  MyDuration duration3 = MyDuration.fromSeconds(30);

  print(duration1 + duration2);
  print(duration1 > duration2);
  print(duration2 + duration3);

  try {
    print(duration2 - duration1);
  } catch (e) {
    print(e);
  }
}
