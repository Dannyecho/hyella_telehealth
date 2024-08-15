class AppointmentInvoiceEntity {
  AppointmentInvoiceEntity({
    required this.appointmentRef,
    required this.totalAmountDue,
    required this.fieldLabel,
    required this.instruction,
    required this.tableRow,
    required this.paymentInfo,
  });

  final String? appointmentRef;
  final int? totalAmountDue;
  final String? fieldLabel;
  final String? instruction;
  final InvoiceTableRow? tableRow;
  final PaymentInfo? paymentInfo;

  AppointmentInvoiceEntity copyWith({
    String? appointmentRef,
    int? totalAmountDue,
    String? fieldLabel,
    String? instruction,
    InvoiceTableRow? tableRow,
    PaymentInfo? paymentInfo,
  }) {
    return AppointmentInvoiceEntity(
      appointmentRef: appointmentRef ?? this.appointmentRef,
      totalAmountDue: totalAmountDue ?? this.totalAmountDue,
      fieldLabel: fieldLabel ?? this.fieldLabel,
      instruction: instruction ?? this.instruction,
      tableRow: tableRow ?? this.tableRow,
      paymentInfo: paymentInfo ?? this.paymentInfo,
    );
  }

  factory AppointmentInvoiceEntity.fromJson(Map<String, dynamic> json) {
    return AppointmentInvoiceEntity(
      appointmentRef: json["appointment_ref"],
      totalAmountDue: json["total_amount_due"],
      fieldLabel: json["field_label"],
      instruction: json["instruction"],
      tableRow: json["table_row"] == null
          ? null
          : InvoiceTableRow.fromJson(json["table_row"]),
      paymentInfo: json["payment_info"] == null
          ? null
          : PaymentInfo.fromJson(json["payment_info"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "appointment_ref": appointmentRef,
        "total_amount_due": totalAmountDue,
        "field_label": fieldLabel,
        "instruction": instruction,
        "table_row": tableRow?.toJson(),
        "payment_info": paymentInfo?.toJson(),
      };

  @override
  String toString() {
    return "$appointmentRef, $totalAmountDue, $fieldLabel, $instruction, $tableRow, $paymentInfo, ";
  }
}

class PaymentInfo {
  PaymentInfo({
    required this.fieldLabel,
    required this.listOption,
  });

  final String? fieldLabel;
  final InvoiceListOption? listOption;

  PaymentInfo copyWith({
    String? fieldLabel,
    InvoiceListOption? listOption,
  }) {
    return PaymentInfo(
      fieldLabel: fieldLabel ?? this.fieldLabel,
      listOption: listOption ?? this.listOption,
    );
  }

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      fieldLabel: json["field_label"],
      listOption: json["list_option"] == null
          ? null
          : InvoiceListOption.fromJson(json["list_option"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "field_label": fieldLabel,
        "list_option": listOption?.toJson(),
      };

  @override
  String toString() {
    return "$fieldLabel, $listOption, ";
  }
}

class InvoiceListOption {
  InvoiceListOption({
    required this.payLater,
    required this.bankTransfer,
    required this.payStack,
  });

  final BankTransfer? payLater;
  final BankTransfer? bankTransfer;
  final BankTransfer? payStack;

  InvoiceListOption copyWith({
    BankTransfer? payLater,
    BankTransfer? bankTransfer,
    BankTransfer? payStack,
  }) {
    return InvoiceListOption(
      payLater: payLater ?? this.payLater,
      bankTransfer: bankTransfer ?? this.bankTransfer,
      payStack: payStack ?? this.payStack,
    );
  }

  factory InvoiceListOption.fromJson(Map<String, dynamic> json) {
    return InvoiceListOption(
      payLater: json["pay_later"] == null
          ? null
          : BankTransfer.fromJson(json["pay_later"]),
      bankTransfer: json["bank_transfer"] == null
          ? null
          : BankTransfer.fromJson(json["bank_transfer"]),
      payStack: json["pay_stack"] == null
          ? null
          : BankTransfer.fromJson(json["pay_stack"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "pay_later": payLater?.toJson(),
        "bank_transfer": bankTransfer?.toJson(),
        "pay_stack": payStack?.toJson(),
      };

  @override
  String toString() {
    return "$payLater, $bankTransfer, $payStack, ";
  }
}

class BankTransfer {
  BankTransfer({
    required this.key,
    required this.title,
    required this.message,
    required this.transactionRef,
  });

  final String? key;
  final String? title;
  final String? message;
  final String? transactionRef;

  BankTransfer copyWith({
    String? key,
    String? title,
    String? message,
    String? transactionRef,
  }) {
    return BankTransfer(
      key: key ?? this.key,
      title: title ?? this.title,
      message: message ?? this.message,
      transactionRef: transactionRef ?? this.transactionRef,
    );
  }

  factory BankTransfer.fromJson(Map<String, dynamic> json) {
    return BankTransfer(
      key: json["key"],
      title: json["title"],
      message: json["message"],
      transactionRef: json["transaction_ref"],
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "title": title,
        "message": message,
        "transaction_ref": transactionRef,
      };

  @override
  String toString() {
    return "$key, $title, $message, $transactionRef, ";
  }
}

class InvoiceTableRow {
  InvoiceTableRow({
    required this.bookingReference,
    required this.description,
    required this.date,
    required this.fee,
  });

  final String? bookingReference;
  final String? description;
  final String? date;
  final String? fee;

  InvoiceTableRow copyWith({
    String? bookingReference,
    String? description,
    String? date,
    String? fee,
  }) {
    return InvoiceTableRow(
      bookingReference: bookingReference ?? this.bookingReference,
      description: description ?? this.description,
      date: date ?? this.date,
      fee: fee ?? this.fee,
    );
  }

  factory InvoiceTableRow.fromJson(Map<String, dynamic> json) {
    return InvoiceTableRow(
      bookingReference: json["Booking Reference"],
      description: json["Description"],
      date: json["Date"],
      fee: json["Fee"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Booking Reference": bookingReference,
        "Description": description,
        "Date": date,
        "Fee": fee,
      };

  @override
  String toString() {
    return "$bookingReference, $description, $date, $fee, ";
  }
}
