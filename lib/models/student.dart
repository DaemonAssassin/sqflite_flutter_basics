import 'dart:convert';

class Student {
  Student({
    this.rollNo,
    this.name,
  });

  int? rollNo;
  String? name;

  Student copyWith({
    int? rollNo,
    String? name,
  }) {
    return Student(
      rollNo: rollNo ?? this.rollNo,
      name: name ?? this.name,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'roll_no': rollNo,
      'name': name,
    };
  }

  factory Student.fromMap(Map<String, Object?> map) {
    return Student(
      rollNo: map['roll_no'] != null ? map['roll_no'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, Object?>);

  @override
  String toString() => 'Student(rollNo: $rollNo, name: $name)';

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.rollNo == rollNo && other.name == name;
  }

  @override
  int get hashCode => rollNo.hashCode ^ name.hashCode;
}
