class TimeSlot {
  final int hour;
  final int minute;

  TimeSlot({required this.hour, this.minute = 0});

  // Map에서 TimeSlot 객체를 생성하는 fromMap 메서드 추가
  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      hour: map['hour'],
      minute: map['minute'],
    );
  }

  // TimeSlot 객체를 Map으로 변환하는 toMap 메서드 추가
  Map<String, dynamic> toMap() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  @override
  String toString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlot &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;
}
