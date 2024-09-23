class LoginResponseEntity {
  LoginResponseEntity({
    required this.type,
    required this.msg,
    required this.data,
  });

  final int? type;
  final String? msg;
  final Data? data;

  LoginResponseEntity copyWith({
    int? type,
    String? msg,
    Data? data,
  }) {
    return LoginResponseEntity(
      type: type ?? this.type,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    return LoginResponseEntity(
      type: json["type"],
      msg: json["msg"],
      data: json["data"] == null || json['data'] is List
          ? null
          : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "msg": msg,
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return "$type, $msg, $data, ";
  }
}

class Data {
  Data({
    required this.sessionId,
    required this.user,
    required this.emr,
    required this.url,
    required this.menu,
    required this.notice,
    required this.trends,
    required this.webViews,
  });

  final String? sessionId;
  final User? user;
  final List<dynamic> emr;
  final String? url;
  final Menu? menu;
  final List<dynamic> notice;
  final List<dynamic> trends;
  final WebViews? webViews;

  Data copyWith({
    String? sessionId,
    User? user,
    List<dynamic>? emr,
    String? url,
    Menu? menu,
    List<dynamic>? notice,
    List<dynamic>? trends,
    WebViews? webViews,
  }) {
    return Data(
      sessionId: sessionId ?? this.sessionId,
      user: user ?? this.user,
      emr: emr ?? this.emr,
      url: url ?? this.url,
      menu: menu ?? this.menu,
      notice: notice ?? this.notice,
      trends: trends ?? this.trends,
      webViews: webViews ?? this.webViews,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sessionId: json["session_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      emr: json["emr"] == null
          ? []
          : List<dynamic>.from(json["emr"]!.map((x) => x)),
      url: json["url"],
      menu: json["menu"] == null ? null : Menu.fromJson(json["menu"]),
      notice: json["notice"] == null
          ? []
          : List<dynamic>.from(json["notice"]!.map((x) => x)),
      trends: json["trends"] == null
          ? []
          : List<dynamic>.from(json["trends"]!.map((x) => x)),
      webViews: json["web_views"] == null
          ? null
          : WebViews.fromJson(json["web_views"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "user": user?.toJson(),
        "emr": emr.map((x) => x).toList(),
        "url": url,
        "menu": menu?.toJson(),
        "notice": notice.map((x) => x).toList(),
        "trends": trends.map((x) => x).toList(),
        "web_views": webViews?.toJson(),
      };

  @override
  String toString() {
    return "$sessionId, $user, $emr, $url, $menu, $notice, $trends, $webViews, ";
  }
}

class Menu {
  Menu({
    required this.cards,
    required this.home,
    required this.more,
  });

  final Cards? cards;
  final Home? home;
  final More? more;

  Menu copyWith({
    Cards? cards,
    Home? home,
    More? more,
  }) {
    return Menu(
      cards: cards ?? this.cards,
      home: home ?? this.home,
      more: more ?? this.more,
    );
  }

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      cards: json["cards"] == null ? null : Cards.fromJson(json["cards"]),
      home: json["home"] == null ? null : Home.fromJson(json["home"]),
      more: json["more"] == null ? null : More.fromJson(json["more"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "cards": cards?.toJson(),
        "home": home?.toJson(),
        "more": more?.toJson(),
      };

  @override
  String toString() {
    return "$cards, $home, $more, ";
  }
}

class Cards {
  Cards({
    required this.title,
    required this.data,
  });

  final String? title;
  final List<CardsDatum> data;

  Cards copyWith({
    String? title,
    List<CardsDatum>? data,
  }) {
    return Cards(
      title: title ?? this.title,
      data: data ?? this.data,
    );
  }

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
      title: json["title"],
      data: json["data"] == null
          ? []
          : List<CardsDatum>.from(
              json["data"]!.map((x) => CardsDatum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$title, $data, ";
  }
}

class CardsDatum {
  CardsDatum({
    required this.key,
    required this.picture,
    required this.title,
    required this.subTitle,
    required this.menuKey,
    required this.info,
  });

  final String? key;
  final String? picture;
  final String? title;
  final String? subTitle;
  final String? menuKey;
  final String? info;

  CardsDatum copyWith({
    String? key,
    String? picture,
    String? title,
    String? subTitle,
    String? menuKey,
    String? info,
  }) {
    return CardsDatum(
      key: key ?? this.key,
      picture: picture ?? this.picture,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      menuKey: menuKey ?? this.menuKey,
      info: info ?? this.info,
    );
  }

  factory CardsDatum.fromJson(Map<String, dynamic> json) {
    return CardsDatum(
      key: json["key"],
      picture: json["picture"],
      title: json["title"],
      subTitle: json["sub_title"],
      menuKey: json["menu_key"],
      info: json["info"],
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "picture": picture,
        "title": title,
        "sub_title": subTitle,
        "menu_key": menuKey,
        "info": info,
      };

  @override
  String toString() {
    return "$key, $picture, $title, $subTitle, $menuKey, $info, ";
  }
}

class Home {
  Home({
    required this.title,
    required this.data,
  });

  final String? title;
  final List<Service> data;

  Home copyWith({
    String? title,
    List<Service>? data,
  }) {
    return Home(
      title: title ?? this.title,
      data: data ?? this.data,
    );
  }

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      title: json["title"],
      data: json["data"] == null
          ? []
          : List<Service>.from(json["data"]!.map((x) => Service.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$title, $data, ";
  }
}

class Service {
  Service({
    required this.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.menuKey,
    required this.appointmentLabel,
    required this.picture,
    required this.endpoint,
  });

  final String? key;
  final String? icon;
  final String? title;
  final String? subTitle;
  final String? menuKey;
  final String? appointmentLabel;
  final String? picture;
  final String? endpoint;

  Service copyWith({
    String? key,
    String? icon,
    String? title,
    String? subTitle,
    String? menuKey,
    String? appointmentLabel,
    String? picture,
    String? endpoint,
  }) {
    return Service(
      key: key ?? this.key,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      menuKey: menuKey ?? this.menuKey,
      appointmentLabel: appointmentLabel ?? this.appointmentLabel,
      picture: picture ?? this.picture,
      endpoint: endpoint ?? this.endpoint,
    );
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      key: json["key"],
      icon: json["icon"],
      title: json["title"],
      subTitle: json["sub_title"],
      menuKey: json["menu_key"],
      appointmentLabel: json["appointment_label"],
      picture: json["picture"],
      endpoint: json["endpoint"],
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "icon": icon,
        "title": title,
        "sub_title": subTitle,
        "menu_key": menuKey,
        "appointment_label": appointmentLabel,
        "picture": picture,
        "endpoint": endpoint,
      };

  @override
  String toString() {
    return "$key, $icon, $title, $subTitle, $menuKey, $appointmentLabel, $picture, $endpoint, ";
  }
}

class More {
  More({
    required this.title,
    required this.htmlContent,
    required this.htmlSrc,
    required this.htmlImg,
    required this.data,
  });

  final String? title;
  final String? htmlContent;
  final String? htmlSrc;
  final String? htmlImg;
  final List<MoreDatum> data;

  More copyWith({
    String? title,
    String? htmlContent,
    String? htmlSrc,
    String? htmlImg,
    List<MoreDatum>? data,
  }) {
    return More(
      title: title ?? this.title,
      htmlContent: htmlContent ?? this.htmlContent,
      htmlSrc: htmlSrc ?? this.htmlSrc,
      htmlImg: htmlImg ?? this.htmlImg,
      data: data ?? this.data,
    );
  }

  factory More.fromJson(Map<String, dynamic> json) {
    return More(
      title: json["title"],
      htmlContent: json["html_content"],
      htmlSrc: json["html_src"],
      htmlImg: json["html_img"],
      data: json["data"] == null
          ? []
          : List<MoreDatum>.from(
              json["data"]!.map((x) => MoreDatum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "html_content": htmlContent,
        "html_src": htmlSrc,
        "html_img": htmlImg,
        "data": data.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$title, $htmlContent, $htmlSrc, $htmlImg, $data, ";
  }
}

class MoreDatum {
  MoreDatum({
    required this.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.menuKey,
  });

  final String? key;
  final String? icon;
  final String? title;
  final String? subTitle;
  final String? menuKey;

  MoreDatum copyWith({
    String? key,
    String? icon,
    String? title,
    String? subTitle,
    String? menuKey,
  }) {
    return MoreDatum(
      key: key ?? this.key,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      menuKey: menuKey ?? this.menuKey,
    );
  }

  factory MoreDatum.fromJson(Map<String, dynamic> json) {
    return MoreDatum(
      key: json["key"],
      icon: json["icon"],
      title: json["title"],
      subTitle: json["sub_title"],
      menuKey: json["menu_key"],
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "icon": icon,
        "title": title,
        "sub_title": subTitle,
        "menu_key": menuKey,
      };

  @override
  String toString() {
    return "$key, $icon, $title, $subTitle, $menuKey, ";
  }
}

class User {
  User({
    required this.pid,
    required this.hasFamily,
    required this.isStaff,
    required this.isPatient,
    required this.isFirstUse,
    required this.isVerified,
    required this.careGiver,
    required this.patientType,
    required this.emrNumber,
    required this.fullName,
    required this.userNameSubtitle,
    required this.initial,
    required this.phone,
    required this.email,
    required this.birthDay,
    required this.dp,
    required this.accBalance,
    required this.accBalanceSubtitle,
    required this.bookAppointment,
    required this.bookAppointmentSubtitle,
    required this.lastName,
    required this.firstName,
    required this.sex,
    required this.religion,
    required this.address,
    required this.nokName,
    required this.nokPhone,
    required this.nokEmail,
    required this.nokAddress,
    required this.allergy,
  });

  final String? pid;
  final int? hasFamily;
  final int? isStaff;
  final int? isPatient;
  final int? isFirstUse;
  final int? isVerified;
  final String? careGiver;
  final String? patientType;
  final String? emrNumber;
  final String? fullName;
  final String? userNameSubtitle;
  final String? initial;
  final String? phone;
  final String? email;
  final String? birthDay;
  final String? dp;
  final String? accBalance;
  final String? accBalanceSubtitle;
  final String? bookAppointment;
  final String? bookAppointmentSubtitle;
  final String? lastName;
  final String? firstName;
  final String? sex;
  final String? religion;
  final String? address;
  final String? nokName;
  final String? nokPhone;
  final String? nokEmail;
  final String? nokAddress;
  final String? allergy;

  User copyWith({
    String? pid,
    int? hasFamily,
    int? isStaff,
    int? isPatient,
    int? isFirstUse,
    int? isVerified,
    String? careGiver,
    String? patientType,
    String? emrNumber,
    String? fullName,
    String? userNameSubtitle,
    String? initial,
    String? phone,
    String? email,
    String? birthDay,
    String? dp,
    String? accBalance,
    String? accBalanceSubtitle,
    String? bookAppointment,
    String? bookAppointmentSubtitle,
    String? lastName,
    String? firstName,
    String? sex,
    String? religion,
    String? address,
    String? nokName,
    String? nokPhone,
    String? nokEmail,
    String? nokAddress,
    String? allergy,
  }) {
    return User(
      pid: pid ?? this.pid,
      hasFamily: hasFamily ?? this.hasFamily,
      isStaff: isStaff ?? this.isStaff,
      isPatient: isPatient ?? this.isPatient,
      isFirstUse: isFirstUse ?? this.isFirstUse,
      isVerified: isVerified ?? this.isVerified,
      careGiver: careGiver ?? this.careGiver,
      patientType: patientType ?? this.patientType,
      emrNumber: emrNumber ?? this.emrNumber,
      fullName: fullName ?? this.fullName,
      userNameSubtitle: userNameSubtitle ?? this.userNameSubtitle,
      initial: initial ?? this.initial,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      birthDay: birthDay ?? this.birthDay,
      dp: dp ?? this.dp,
      accBalance: accBalance ?? this.accBalance,
      accBalanceSubtitle: accBalanceSubtitle ?? this.accBalanceSubtitle,
      bookAppointment: bookAppointment ?? this.bookAppointment,
      bookAppointmentSubtitle:
          bookAppointmentSubtitle ?? this.bookAppointmentSubtitle,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      sex: sex ?? this.sex,
      religion: religion ?? this.religion,
      address: address ?? this.address,
      nokName: nokName ?? this.nokName,
      nokPhone: nokPhone ?? this.nokPhone,
      nokEmail: nokEmail ?? this.nokEmail,
      nokAddress: nokAddress ?? this.nokAddress,
      allergy: allergy ?? this.allergy,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pid: json["pid"],
      hasFamily: json["has_family"],
      isStaff: json["is_staff"],
      isPatient: json["is_patient"],
      isFirstUse: json["is_first_use"],
      isVerified: json["is_verified"],
      careGiver: json["care_giver"],
      patientType: json["patient_type"],
      emrNumber: json["emr_number"],
      fullName: json["full_name"],
      userNameSubtitle: json["user_name_subtitle"],
      initial: json["initial"],
      phone: json["phone"],
      email: json["email"],
      birthDay: json["birth_day"],
      dp: json["dp"],
      accBalance: json["acc_balance"],
      accBalanceSubtitle: json["acc_balance_subtitle"],
      bookAppointment: json["book_appointment"],
      bookAppointmentSubtitle: json["book_appointment_subtitle"],
      lastName: json["last_name"],
      firstName: json["first_name"],
      sex: json["sex"],
      religion: json["religion"],
      address: json["address"],
      nokName: json["nok_name"],
      nokPhone: json["nok_phone"],
      nokEmail: json["nok_email"],
      nokAddress: json["nok_address"],
      allergy: json["allergy"],
    );
  }

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "has_family": hasFamily,
        "is_staff": isStaff,
        "is_patient": isPatient,
        "is_first_use": isFirstUse,
        "is_verified": isVerified,
        "care_giver": careGiver,
        "patient_type": patientType,
        "emr_number": emrNumber,
        "full_name": fullName,
        "user_name_subtitle": userNameSubtitle,
        "initial": initial,
        "phone": phone,
        "email": email,
        "birth_day": birthDay,
        "dp": dp,
        "acc_balance": accBalance,
        "acc_balance_subtitle": accBalanceSubtitle,
        "book_appointment": bookAppointment,
        "book_appointment_subtitle": bookAppointmentSubtitle,
        "last_name": lastName,
        "first_name": firstName,
        "sex": sex,
        "religion": religion,
        "address": address,
        "nok_name": nokName,
        "nok_phone": nokPhone,
        "nok_email": nokEmail,
        "nok_address": nokAddress,
        "allergy": allergy,
      };

  @override
  String toString() {
    return "$pid, $hasFamily, $isStaff, $isPatient, $isFirstUse, $isVerified, $careGiver, $patientType, $emrNumber, $fullName, $userNameSubtitle, $initial, $phone, $email, $birthDay, $dp, $accBalance, $accBalanceSubtitle, $bookAppointment, $bookAppointmentSubtitle, $lastName, $firstName, $sex, $religion, $address, $nokName, $nokPhone, $nokEmail, $nokAddress, $allergy, ";
  }
}

class WebViews {
  WebViews({
    required this.chat,
    required this.chatMsg,
    required this.appBook,
    required this.services,
    required this.more,
    required this.profile,
    required this.schedule,
    required this.home,
    required this.videoChat,
    required this.bookAppointment,
    required this.rescheduleAppointment,
  });

  final AppBook? chat;
  final AppBook? chatMsg;
  final AppBook? appBook;
  final AppBook? services;
  final AppBook? more;
  final AppBook? profile;
  final AppBook? schedule;
  final AppBook? home;
  final AppBook? videoChat;
  final AppBook? bookAppointment;
  final AppBook? rescheduleAppointment;

  WebViews copyWith({
    AppBook? chat,
    AppBook? chatMsg,
    AppBook? appBook,
    AppBook? services,
    AppBook? more,
    AppBook? profile,
    AppBook? schedule,
    AppBook? home,
    AppBook? videoChat,
    AppBook? bookAppointment,
    AppBook? rescheduleAppointment,
  }) {
    return WebViews(
      chat: chat ?? this.chat,
      chatMsg: chatMsg ?? this.chatMsg,
      appBook: appBook ?? this.appBook,
      services: services ?? this.services,
      more: more ?? this.more,
      profile: profile ?? this.profile,
      schedule: schedule ?? this.schedule,
      home: home ?? this.home,
      videoChat: videoChat ?? this.videoChat,
      bookAppointment: bookAppointment ?? this.bookAppointment,
      rescheduleAppointment:
          rescheduleAppointment ?? this.rescheduleAppointment,
    );
  }

  factory WebViews.fromJson(Map<String, dynamic> json) {
    return WebViews(
      chat: json["chat"] == null ? null : AppBook.fromJson(json["chat"]),
      chatMsg:
          json["chat_msg"] == null ? null : AppBook.fromJson(json["chat_msg"]),
      appBook:
          json["app_book"] == null ? null : AppBook.fromJson(json["app_book"]),
      services:
          json["services"] == null ? null : AppBook.fromJson(json["services"]),
      more: json["more"] == null ? null : AppBook.fromJson(json["more"]),
      profile:
          json["profile"] == null ? null : AppBook.fromJson(json["profile"]),
      schedule:
          json["schedule"] == null ? null : AppBook.fromJson(json["schedule"]),
      home: json["home"] == null ? null : AppBook.fromJson(json["home"]),
      videoChat: json["video_chat"] == null
          ? null
          : AppBook.fromJson(json["video_chat"]),
      bookAppointment: json["book_appointment"] == null
          ? null
          : AppBook.fromJson(json["book_appointment"]),
      rescheduleAppointment: json["reschedule_appointment"] == null
          ? null
          : AppBook.fromJson(json["reschedule_appointment"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "chat": chat?.toJson(),
        "chat_msg": chatMsg?.toJson(),
        "app_book": appBook?.toJson(),
        "services": services?.toJson(),
        "more": more?.toJson(),
        "profile": profile?.toJson(),
        "schedule": schedule?.toJson(),
        "home": home?.toJson(),
        "video_chat": videoChat?.toJson(),
        "book_appointment": bookAppointment?.toJson(),
        "reschedule_appointment": rescheduleAppointment?.toJson(),
      };

  @override
  String toString() {
    return "$chat, $chatMsg, $appBook, $services, $more, $profile, $schedule, $home, $videoChat, $bookAppointment, $rescheduleAppointment, ";
  }
}

class AppBook {
  AppBook({
    required this.webview,
    required this.endpoint,
    required this.params,
  });

  final int? webview;
  final String? endpoint;
  final Params? params;

  AppBook copyWith({
    int? webview,
    String? endpoint,
    Params? params,
  }) {
    return AppBook(
      webview: webview ?? this.webview,
      endpoint: endpoint ?? this.endpoint,
      params: params ?? this.params,
    );
  }

  factory AppBook.fromJson(Map<String, dynamic> json) {
    return AppBook(
      webview: json["webview"],
      endpoint: json["endpoint"],
      params: json["params"] == null ? null : Params.fromJson(json["params"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "webview": webview,
        "endpoint": endpoint,
        "params": params?.toJson(),
      };

  @override
  String toString() {
    return "$webview, $endpoint, $params, ";
  }
}

class Params {
  Params({
    required this.token,
    required this.nwpWebiew,
    required this.pid,
    required this.hash,
  });

  final String? token;
  final String? nwpWebiew;
  final String? pid;
  final String? hash;

  Params copyWith({
    String? token,
    String? nwpWebiew,
    String? pid,
    String? hash,
  }) {
    return Params(
      token: token ?? this.token,
      nwpWebiew: nwpWebiew ?? this.nwpWebiew,
      pid: pid ?? this.pid,
      hash: hash ?? this.hash,
    );
  }

  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(
      token: json["token"],
      nwpWebiew: json["nwp_webiew"],
      pid: json["pid"],
      hash: json["hash"],
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "nwp_webiew": nwpWebiew,
        "pid": pid,
        "hash": hash,
      };

  @override
  String toString() {
    return "$token, $nwpWebiew, $pid, $hash, ";
  }
}
