part of 'appointment_bloc.dart';

class AppointmentState {
  final SelectOptionEntity? department;
  final SelectOptionEntity? doctor;
  final SelectOptionEntity? location;
  final DateTime? date;
  final SelectOptionEntity? time;
  final String? comment;
  final SelectOptionEntity? cus_id;

  AppointmentState({
    this.department,
    this.doctor,
    this.location,
    this.date,
    this.time,
    this.comment,
    this.cus_id,
  });

  AppointmentState copyWith({
    SelectOptionEntity? department,
    SelectOptionEntity? doctor,
    SelectOptionEntity? location,
    DateTime? date,
    SelectOptionEntity? time,
    String? comment,
    SelectOptionEntity? cus_id,
  }) {
    return AppointmentState(
      department: department ?? this.department,
      doctor: doctor ?? this.doctor,
      location: location ?? this.location,
      date: date ?? this.date,
      time: time ?? this.time,
      comment: comment ?? this.comment,
      cus_id: cus_id ?? this.cus_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'department': department,
      'doctor': doctor,
      'location': location,
      'date': date,
      'time': time,
      'comment': comment,
      'cus_id': cus_id,
    };
  }

  factory AppointmentState.fromMap(Map<String, dynamic> map) {
    return AppointmentState(
      department: map['department'] as SelectOptionEntity,
      doctor: map['doctor'] as SelectOptionEntity,
      location: map['location'] as SelectOptionEntity,
      date: map['date'] as DateTime,
      time: map['time'] as SelectOptionEntity,
      comment: map['comment'],
      cus_id: map['cus_id'] as SelectOptionEntity,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentState.fromJson(String source) =>
      AppointmentState.fromMap(json.decode(source) as Map<String, dynamic>);
}
