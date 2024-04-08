class TimeSlotD {
  final int hour;
  final int minute;

  TimeSlotD({required this.hour, this.minute = 0});

  // Map에서 TimeSlotD 객체를 생성하는 fromMap 메서드 추가
  factory TimeSlotD.fromMap(Map<String, dynamic> map) {
    return TimeSlotD(
      hour: map['hour'],
      minute: map['minute'],
    );
  }

  // TimeSlotD 객체를 Map으로 변환하는 toMap 메서드 추가
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
      other is TimeSlotD &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;
}
