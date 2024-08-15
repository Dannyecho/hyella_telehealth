class AppointmentBookingConfirmationEntity {
  AppointmentBookingConfirmationEntity({
    required this.transactionRef,
    required this.fieldLabel,
    required this.appointmentConfirmationListOption,
    required this.urlTitle,
    required this.url,
  });

  final String? transactionRef;
  final String? fieldLabel;
  final AppointmentConfirmationListOption? appointmentConfirmationListOption;
  final String? urlTitle;
  final String? url;

  AppointmentBookingConfirmationEntity copyWith({
    String? transactionRef,
    String? fieldLabel,
    AppointmentConfirmationListOption? appointmentConfirmationListOption,
    String? urlTitle,
    String? url,
  }) {
    return AppointmentBookingConfirmationEntity(
      transactionRef: transactionRef ?? this.transactionRef,
      fieldLabel: fieldLabel ?? this.fieldLabel,
      appointmentConfirmationListOption: appointmentConfirmationListOption ??
          this.appointmentConfirmationListOption,
      urlTitle: urlTitle ?? this.urlTitle,
      url: url ?? this.url,
    );
  }

  factory AppointmentBookingConfirmationEntity.fromJson(
      Map<String, dynamic> json) {
    return AppointmentBookingConfirmationEntity(
      transactionRef: json["transaction_ref"],
      fieldLabel: json["field_label"],
      appointmentConfirmationListOption: json["list_option"] == null
          ? null
          : AppointmentConfirmationListOption.fromJson(json["list_option"]),
      urlTitle: json["url_title"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "transaction_ref": transactionRef,
        "field_label": fieldLabel,
        "list_option": appointmentConfirmationListOption?.toJson(),
        "url_title": urlTitle,
        "url": url,
      };

  @override
  String toString() {
    return "$transactionRef, $fieldLabel, $appointmentConfirmationListOption, $urlTitle, $url, ";
  }
}

class AppointmentConfirmationListOption {
  AppointmentConfirmationListOption({
    required this.appointmentBookingStatus,
    required this.whomToSee,
    required this.when,
    required this.paymentStatus,
  });

  final String? appointmentBookingStatus;
  final String? whomToSee;
  final String? when;
  final String? paymentStatus;

  AppointmentConfirmationListOption copyWith({
    String? appointmentBookingStatus,
    String? whomToSee,
    String? when,
    String? paymentStatus,
  }) {
    return AppointmentConfirmationListOption(
      appointmentBookingStatus:
          appointmentBookingStatus ?? this.appointmentBookingStatus,
      whomToSee: whomToSee ?? this.whomToSee,
      when: when ?? this.when,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }

  factory AppointmentConfirmationListOption.fromJson(
      Map<String, dynamic> json) {
    return AppointmentConfirmationListOption(
      appointmentBookingStatus: json["Appointment Booking Status"],
      whomToSee: json["Whom to See"],
      when: json["When"],
      paymentStatus: json["Payment Status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Appointment Booking Status": appointmentBookingStatus,
        "Whom to See": whomToSee,
        "When": when,
        "Payment Status": paymentStatus,
      };

  @override
  String toString() {
    return "$appointmentBookingStatus, $whomToSee, $when, $paymentStatus, ";
  }
}
