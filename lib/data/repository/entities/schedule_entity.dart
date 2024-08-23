class ScheduleEntity {
  ScheduleEntity({
    required this.appList,
    required this.appListType,
    required this.appListCount,
  });

  final ScheduleEntityAppList? appList;
  final String? appListType;
  final int? appListCount;

  ScheduleEntity copyWith({
    ScheduleEntityAppList? appList,
    String? appListType,
    int? appListCount,
  }) {
    return ScheduleEntity(
      appList: appList ?? this.appList,
      appListType: appListType ?? this.appListType,
      appListCount: appListCount ?? this.appListCount,
    );
  }

  factory ScheduleEntity.fromJson(Map<String, dynamic> json) {
    return ScheduleEntity(
      appList: json["app_list"] == null
          ? null
          : ScheduleEntityAppList.fromJson(json["app_list"]),
      appListType: json["app_list_type"],
      appListCount: json["app_list_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "app_list": appList?.toJson(),
        "app_list_type": appListType,
        "app_list_count": appListCount,
      };

  @override
  String toString() {
    return "$appList, $appListType, $appListCount, ";
  }
}

class ScheduleEntityAppList {
  ScheduleEntityAppList({
    this.upcoming,
    this.completed,
    this.cancelled,
  });

  final Map<String, ScheduleEntityData>? upcoming;
  final Map<String, ScheduleEntityData>? completed;
  final Map<String, ScheduleEntityData>? cancelled;

  ScheduleEntityAppList copyWith({
    Map<String, ScheduleEntityData>? upcoming,
    Map<String, ScheduleEntityData>? completed,
    Map<String, ScheduleEntityData>? cancelled,
  }) {
    return ScheduleEntityAppList(
      upcoming: upcoming ?? this.upcoming,
      completed: completed ?? this.completed,
      cancelled: cancelled ?? this.cancelled,
    );
  }

  factory ScheduleEntityAppList.fromJson(Map<String, dynamic> json) {
    return ScheduleEntityAppList(
      upcoming: json.containsKey('upcoming')
          ? Map.from(json["upcoming"]).map((k, v) =>
              MapEntry<String, ScheduleEntityData>(
                  k, ScheduleEntityData.fromJson(v)))
          : null,
      completed: json.containsKey('completed')
          ? Map.from(json["completed"]).map((k, v) =>
              MapEntry<String, ScheduleEntityData>(
                  k, ScheduleEntityData.fromJson(v)))
          : null,
      cancelled: json.containsKey('cancelled')
          ? Map.from(json["cancelled"]).map((k, v) =>
              MapEntry<String, ScheduleEntityData>(
                  k, ScheduleEntityData.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "upcoming": Map.from(upcoming!)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "completed": Map.from(completed!)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "cancelled": Map.from(cancelled!)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
      };

  @override
  String toString() {
    return "$upcoming, ";
  }
}

class ScheduleEntityData {
  ScheduleEntityData({
    required this.date,
    required this.status,
    required this.key,
    required this.appointmentId,
    required this.time,
    required this.doctorId,
    required this.receiverId,
    required this.channelName,
    required this.title,
    required this.picture,
    required this.specialtyKey,
    required this.subTitle,
  });

  final String? date;
  final String? status;
  final String? key;
  final String? appointmentId;
  final String? time;
  final String? doctorId;
  final String? receiverId;
  final String? channelName;
  final String? title;
  final String? picture;
  final String? specialtyKey;
  final String? subTitle;

  ScheduleEntityData copyWith({
    String? date,
    String? status,
    String? key,
    String? appointmentId,
    String? time,
    String? doctorId,
    String? receiverId,
    String? channelName,
    String? title,
    String? picture,
    String? specialtyKey,
    String? subTitle,
  }) {
    return ScheduleEntityData(
      date: date ?? this.date,
      status: status ?? this.status,
      key: key ?? this.key,
      appointmentId: appointmentId ?? this.appointmentId,
      time: time ?? this.time,
      doctorId: doctorId ?? this.doctorId,
      receiverId: receiverId ?? this.receiverId,
      channelName: channelName ?? this.channelName,
      title: title ?? this.title,
      picture: picture ?? this.picture,
      specialtyKey: specialtyKey ?? this.specialtyKey,
      subTitle: subTitle ?? this.subTitle,
    );
  }

  factory ScheduleEntityData.fromJson(Map<String, dynamic> json) {
    return ScheduleEntityData(
      date: json["date"],
      status: json["status"],
      key: json["key"],
      appointmentId: json["appointment_id"],
      time: json["time"],
      doctorId: json["doctor_id"],
      receiverId: json["receiver_id"],
      channelName: json["channel_name"],
      title: json["title"],
      picture: json["picture"],
      specialtyKey: json["specialty_key"],
      subTitle: json["sub_title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
        "key": key,
        "appointment_id": appointmentId,
        "time": time,
        "doctor_id": doctorId,
        "receiver_id": receiverId,
        "channel_name": channelName,
        "title": title,
        "picture": picture,
        "specialty_key": specialtyKey,
        "sub_title": subTitle,
      };

  @override
  String toString() {
    return "$date, $status, $key, $appointmentId, $time, $doctorId, $receiverId, $channelName, $title, $picture, $specialtyKey, $subTitle, ";
  }
}
