// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EndPointEntityDataFormsResetPasswordFields extends EndpointFormFields {
/*
{
  "name": "email",
  "field_label": "Email",
  "form_field": "email",
  "required_field": 1,
  "validation_message": "Please provide your email address",
  "note": "",
  "min": 0,
  "max": 50
} 
*/

  String? name;
  String? fieldLabel;
  String? formField;
  int? requiredField;
  String? validationMessage;
  String? note;
  int? min;
  int? max;

  EndPointEntityDataFormsResetPasswordFields({
    this.name,
    this.fieldLabel,
    this.formField,
    this.requiredField,
    this.validationMessage,
    this.note,
    this.min,
    this.max,
  });
  EndPointEntityDataFormsResetPasswordFields.fromJson(
      Map<String, dynamic> json) {
    name = json['name']?.toString();
    fieldLabel = json['field_label']?.toString();
    formField = json['form_field']?.toString();
    requiredField = json['required_field']?.toInt();
    validationMessage = json['validation_message']?.toString();
    note = json['note']?.toString();
    min = json['min']?.toInt();
    max = json['max']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['field_label'] = fieldLabel;
    data['form_field'] = formField;
    data['required_field'] = requiredField;
    data['validation_message'] = validationMessage;
    data['note'] = note;
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}

class EndPointEntityDataFormsResetPassword extends EndpointForms {
/*
{
  "title": "Reset Password",
  "subtitle": "Reset your password",
  "action": "user_mgt_reset",
  "nwp_request": "nwp_dynamic_form",
  "fields": [
    {
      "name": "email",
      "field_label": "Email",
      "form_field": "email",
      "required_field": 1,
      "validation_message": "Please provide your email address",
      "note": "",
      "min": 0,
      "max": 50
    }
  ]
} 
*/

  String? title;
  String? subtitle;
  String? action;
  String? nwpRequest;
  List<EndPointEntityDataFormsResetPasswordFields?>? fields;

  EndPointEntityDataFormsResetPassword({
    this.title,
    this.subtitle,
    this.action,
    this.nwpRequest,
    this.fields,
  });
  EndPointEntityDataFormsResetPassword.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    subtitle = json['subtitle']?.toString();
    action = json['action']?.toString();
    nwpRequest = json['nwp_request']?.toString();
    if (json['fields'] != null) {
      final v = json['fields'];
      final arr0 = <EndPointEntityDataFormsResetPasswordFields>[];
      v.forEach((v) {
        arr0.add(EndPointEntityDataFormsResetPasswordFields.fromJson(v));
      });
      fields = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['action'] = action;
    data['nwp_request'] = nwpRequest;
    if (fields != null) {
      final v = fields;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['fields'] = arr0;
    }
    return data;
  }
}

class EndPointEntityDataFormsProfileUpdateFields extends EndpointFormFields {
/*
{
  "name": "first_name",
  "field_label": "First Name",
  "form_field": "text",
  "required_field": 1,
  "validation_message": "Please provide the right information"
} 
*/

  String? name;
  String? fieldLabel;
  String? formField;
  int? requiredField;
  String? validationMessage;
  dynamic value;
  List<FormFieldOption?>? formFieldOptions;

  EndPointEntityDataFormsProfileUpdateFields({
    this.name,
    this.fieldLabel,
    this.formField,
    this.requiredField,
    this.validationMessage,
    this.value,
    this.formFieldOptions,
  });
  EndPointEntityDataFormsProfileUpdateFields.fromJson(
      Map<String, dynamic> json) {
    name = json['name']?.toString();
    fieldLabel = json['field_label']?.toString();
    formField = json['form_field']?.toString();
    requiredField = json['required_field']?.toInt();
    validationMessage = json['validation_message']?.toString();
    value = json['value']?.toString();
    formFieldOptions = (json['form_field_options'] as Map?)
        ?.entries
        .map((entry) => FormFieldOption(key: entry.key, value: entry.value))
        .toList();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['field_label'] = fieldLabel;
    data['form_field'] = formField;
    data['required_field'] = requiredField;
    data['validation_message'] = validationMessage;
    data['value'] = value;
    return data;
  }
}

class FormFieldOption {
  final String key;
  final String value;
  FormFieldOption({required this.key, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory FormFieldOption.fromMap(Map<String, dynamic> map) {
    return FormFieldOption(
      key: map['key'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormFieldOption.fromJson(String source) =>
      FormFieldOption.fromMap(json.decode(source) as Map<String, dynamic>);
}

class EndPointEntityDataFormsProfileUpdate extends EndpointForms {
/*
{
  "title": "Profile Update",
  "subtitle": "Update your profile & other info",
  "action": "user_mgt_update_profile",
  "nwp_request": "nwp_dynamic_form",
  "fields": [
    {
      "name": "first_name",
      "field_label": "First Name",
      "form_field": "text",
      "required_field": 1,
      "validation_message": "Please provide the right information"
    }
  ]
} 
*/

  String? title;
  String? subtitle;
  String? action;
  String? nwpRequest;
  List<EndPointEntityDataFormsProfileUpdateFields?>? fields;

  EndPointEntityDataFormsProfileUpdate({
    this.title,
    this.subtitle,
    this.action,
    this.nwpRequest,
    this.fields,
  });
  EndPointEntityDataFormsProfileUpdate.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    subtitle = json['subtitle']?.toString();
    action = json['action']?.toString();
    nwpRequest = json['nwp_request']?.toString();
    if (json['fields'] != null) {
      final v = json['fields'];
      final arr0 = <EndPointEntityDataFormsProfileUpdateFields>[];
      v.forEach((v) {
        arr0.add(EndPointEntityDataFormsProfileUpdateFields.fromJson(v));
      });
      fields = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['action'] = action;
    data['nwp_request'] = nwpRequest;
    if (fields != null) {
      final v = fields;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['fields'] = arr0;
    }
    return data;
  }
}

class EndPointEntityDataFormsSignInFields extends EndpointFormFields {
/*
{
  "name": "email",
  "field_label": "Email",
  "form_field": "email",
  "required_field": 1,
  "validation_message": "Please provide your email address",
  "note": "",
  "min": 0,
  "max": 50
} 
*/

  String? name;
  String? fieldLabel;
  String? formField;
  int? requiredField;
  String? validationMessage;
  String? note;
  int? min;
  int? max;

  EndPointEntityDataFormsSignInFields({
    this.name,
    this.fieldLabel,
    this.formField,
    this.requiredField,
    this.validationMessage,
    this.note,
    this.min,
    this.max,
  });
  EndPointEntityDataFormsSignInFields.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    fieldLabel = json['field_label']?.toString();
    formField = json['form_field']?.toString();
    requiredField = json['required_field']?.toInt();
    validationMessage = json['validation_message']?.toString();
    note = json['note']?.toString();
    min = json['min']?.toInt();
    max = json['max']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['field_label'] = fieldLabel;
    data['form_field'] = formField;
    data['required_field'] = requiredField;
    data['validation_message'] = validationMessage;
    data['note'] = note;
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}

class EndPointEntityDataFormsSignIn extends EndpointForms {
/*
{
  "title": "Sign In",
  "subtitle": "Sign-in and enjoy yourself",
  "action": "user_mgt_login",
  "nwp_request": "nwp_dynamic_form",
  "fields": [
    {
      "name": "email",
      "field_label": "Email",
      "form_field": "email",
      "required_field": 1,
      "validation_message": "Please provide your email address",
      "note": "",
      "min": 0,
      "max": 50
    }
  ]
} 
*/

  String? title;
  String? subtitle;
  String? action;
  String? nwpRequest;
  List<EndPointEntityDataFormsSignInFields?>? fields;

  EndPointEntityDataFormsSignIn({
    this.title,
    this.subtitle,
    this.action,
    this.nwpRequest,
    this.fields,
  });
  EndPointEntityDataFormsSignIn.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    subtitle = json['subtitle']?.toString();
    action = json['action']?.toString();
    nwpRequest = json['nwp_request']?.toString();
    if (json['fields'] != null) {
      final v = json['fields'];
      final arr0 = <EndPointEntityDataFormsSignInFields>[];
      v.forEach((v) {
        arr0.add(EndPointEntityDataFormsSignInFields.fromJson(v));
      });
      fields = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['action'] = action;
    data['nwp_request'] = nwpRequest;
    if (fields != null) {
      final v = fields;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['fields'] = arr0;
    }
    return data;
  }
}

class EndPointEntityDataFormsSignUpFields extends EndpointFormFields {
/*
{
  "name": "first_name",
  "field_label": "First Name",
  "form_field": "text",
  "required_field": 1,
  "validation_message": "Please provide the right information"
} 
*/

  String? name;
  String? fieldLabel;
  String? formField;
  int? requiredField;
  dynamic value;
  String? validationMessage;
  List<FormFieldOption?>? formFieldOptions;

  EndPointEntityDataFormsSignUpFields({
    this.name,
    this.fieldLabel,
    this.formField,
    this.requiredField,
    this.validationMessage,
    this.value,
    List<FormFieldOption?>? formFieldOptions,
  });
  EndPointEntityDataFormsSignUpFields.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    fieldLabel = json['field_label']?.toString();
    formField = json['form_field']?.toString();
    requiredField = json['required_field']?.toInt();
    validationMessage = json['validation_message']?.toString();
    value = json['value']?.toString();
    formFieldOptions = (json['form_field_options'] as Map?)
        ?.entries
        .map((entry) => FormFieldOption(key: entry.key, value: entry.value))
        .toList();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['field_label'] = fieldLabel;
    data['form_field'] = formField;
    data['required_field'] = requiredField;
    data['validation_message'] = validationMessage;
    data['value'] = value;
    // data['form_field_option'] = formFieldOptions;
    return data;
  }
}

class EndPointEntityDataFormsSignUp extends EndpointForms {
/*
{
  "title": "Register Now",
  "subtitle": "Signup with us and share our resources",
  "action": "user_mgts_register",
  "nwp_request": "nwp_dynamic_form",
  "fields": [
    {
      "name": "first_name",
      "field_label": "First Name",
      "form_field": "text",
      "required_field": 1,
      "validation_message": "Please provide the right information"
    }
  ]
} 
*/

  String? title;
  String? subtitle;
  String? action;
  String? nwpRequest;
  @override
  List<EndPointEntityDataFormsSignUpFields?>? fields;

  EndPointEntityDataFormsSignUp({
    this.title,
    this.subtitle,
    this.action,
    this.nwpRequest,
    this.fields,
  });
  EndPointEntityDataFormsSignUp.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    subtitle = json['subtitle']?.toString();
    action = json['action']?.toString();
    nwpRequest = json['nwp_request']?.toString();
    if (json['fields'] != null) {
      final v = json['fields'];
      final arr0 = <EndPointEntityDataFormsSignUpFields>[];
      v.forEach((v) {
        arr0.add(EndPointEntityDataFormsSignUpFields.fromJson(v));
      });
      fields = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['action'] = action;
    data['nwp_request'] = nwpRequest;
    if (fields != null) {
      final v = fields;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['fields'] = arr0;
    }
    return data;
  }
}

class EndPointEntityDataForms {
/*
{
  "sign_up": [
    {
      "title": "Register Now",
      "subtitle": "Signup with us and share our resources",
      "action": "user_mgts_register",
      "nwp_request": "nwp_dynamic_form",
      "fields": [
        {
          "name": "first_name",
          "field_label": "First Name",
          "form_field": "text",
          "required_field": 1,
          "validation_message": "Please provide the right information"
        }
      ]
    }
  ],
  "sign_in": {
    "title": "Sign In",
    "subtitle": "Sign-in and enjoy yourself",
    "action": "user_mgt_login",
    "nwp_request": "nwp_dynamic_form",
    "fields": [
      {
        "name": "email",
        "field_label": "Email",
        "form_field": "email",
        "required_field": 1,
        "validation_message": "Please provide your email address",
        "note": "",
        "min": 0,
        "max": 50
      }
    ]
  },
  "profile_update": {
    "title": "Profile Update",
    "subtitle": "Update your profile & other info",
    "action": "user_mgt_update_profile",
    "nwp_request": "nwp_dynamic_form",
    "fields": [
      {
        "name": "first_name",
        "field_label": "First Name",
        "form_field": "text",
        "required_field": 1,
        "validation_message": "Please provide the right information"
      }
    ]
  },
  "reset_password": {
    "title": "Reset Password",
    "subtitle": "Reset your password",
    "action": "user_mgt_reset",
    "nwp_request": "nwp_dynamic_form",
    "fields": [
      {
        "name": "email",
        "field_label": "Email",
        "form_field": "email",
        "required_field": 1,
        "validation_message": "Please provide your email address",
        "note": "",
        "min": 0,
        "max": 50
      }
    ]
  }
} 
*/

  List<EndPointEntityDataFormsSignUp?>? signUp;
  EndPointEntityDataFormsSignIn? signIn;
  EndPointEntityDataFormsProfileUpdate? profileUpdate;
  EndPointEntityDataFormsResetPassword? resetPassword;

  EndPointEntityDataForms({
    this.signUp,
    this.signIn,
    this.profileUpdate,
    this.resetPassword,
  });
  EndPointEntityDataForms.fromJson(Map<String, dynamic> json) {
    if (json['sign_up'] != null) {
      final v = json['sign_up'];
      final arr0 = <EndPointEntityDataFormsSignUp>[];
      v.forEach((v) {
        arr0.add(EndPointEntityDataFormsSignUp.fromJson(v));
      });
      signUp = arr0;
    }
    signIn = (json['sign_in'] != null)
        ? EndPointEntityDataFormsSignIn.fromJson(json['sign_in'])
        : null;
    profileUpdate = (json['profile_update'] != null)
        ? EndPointEntityDataFormsProfileUpdate.fromJson(json['profile_update'])
        : null;
    resetPassword = (json['reset_password'] != null)
        ? EndPointEntityDataFormsResetPassword.fromJson(json['reset_password'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (signUp != null) {
      final v = signUp;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['sign_up'] = arr0;
    }
    if (signIn != null) {
      data['sign_in'] = signIn!.toJson();
    }
    if (profileUpdate != null) {
      data['profile_update'] = profileUpdate!.toJson();
    }
    if (resetPassword != null) {
      data['reset_password'] = resetPassword!.toJson();
    }
    return data;
  }
}

class EndPointEntityDataPaystackPayment {
/*
{
  "gateway": "paystack",
  "public_key": "pk_live_20c0e30788a06575f7716882b6f23692202ee7e8",
  "encryption_key": "sk_live_3b9887039701fc97ba4aac0b2dd1f640aed7ea67"
} 
*/

  String? gateway;
  String? publicKey;
  String? encryptionKey;

  EndPointEntityDataPaystackPayment({
    this.gateway,
    this.publicKey,
    this.encryptionKey,
  });
  EndPointEntityDataPaystackPayment.fromJson(Map<String, dynamic> json) {
    gateway = json['gateway']?.toString();
    publicKey = json['public_key']?.toString();
    encryptionKey = json['encryption_key']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gateway'] = gateway;
    data['public_key'] = publicKey;
    data['encryption_key'] = encryptionKey;
    return data;
  }
}

class EndPointEntityDataFlutterPayment {
/*
{
  "gateway": "flutterwave",
  "public_key": "FLWPUBK-3acf3d8eb36b49e09f92b0a3aa598bec-X",
  "encryption_key": "d32ee24e2de3134d94fd3613"
} 
*/

  String? gateway;
  String? publicKey;
  String? encryptionKey;

  EndPointEntityDataFlutterPayment({
    this.gateway,
    this.publicKey,
    this.encryptionKey,
  });
  EndPointEntityDataFlutterPayment.fromJson(Map<String, dynamic> json) {
    gateway = json['gateway']?.toString();
    publicKey = json['public_key']?.toString();
    encryptionKey = json['encryption_key']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gateway'] = gateway;
    data['public_key'] = publicKey;
    data['encryption_key'] = encryptionKey;
    return data;
  }
}

class EndPointEntityDataClient {
/*
{
  "id": "101",
  "name": "Demo Hospital Ltd.",
  "tagline": "Home of maternity and safe delivery",
  "logo": "https://webapp.hyella.com.ng/demo/thealth/demo/logo.jpg",
  "social_login": 1,
  "color1": "#0979ba",
  "color2": "#4CB050",
  "color3": "#9FECBE",
  "color4": "#FF9700",
  "color5": "#FAD97A",
  "color6": "#FAF1E8"
} 
*/

  String? id;
  String? name;
  String? tagline;
  String? logo;
  int? socialLogin;
  String? color1;
  String? color2;
  String? color3;
  String? color4;
  String? color5;
  String? color6;

  EndPointEntityDataClient({
    this.id,
    this.name,
    this.tagline,
    this.logo,
    this.socialLogin,
    this.color1,
    this.color2,
    this.color3,
    this.color4,
    this.color5,
    this.color6,
  });
  EndPointEntityDataClient.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    tagline = json['tagline']?.toString();
    logo = json['logo']?.toString();
    socialLogin = json['social_login']?.toInt();
    color1 = json['color1']?.toString();
    color2 = json['color2']?.toString();
    color3 = json['color3']?.toString();
    color4 = json['color4']?.toString();
    color5 = json['color5']?.toString();
    color6 = json['color6']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tagline'] = tagline;
    data['logo'] = logo;
    data['social_login'] = socialLogin;
    data['color1'] = color1;
    data['color2'] = color2;
    data['color3'] = color3;
    data['color4'] = color4;
    data['color5'] = color5;
    data['color6'] = color6;
    return data;
  }
}

class EndPointEntityData {
/*
{
  "end_point1": "https://webapp.hyella.com.ng/demo/emr-v1.3/engine/api/",
  "end_point2": "",
  "end_point3": "",
  "private_key": "7aa2781285b5c85d34e96078039be80e",
  "agora_api_key": "f7921f7371364666a5ba490e82cfb935",
  "client": {
    "id": "101",
    "name": "Demo Hospital Ltd.",
    "tagline": "Home of maternity and safe delivery",
    "logo": "https://webapp.hyella.com.ng/demo/thealth/demo/logo.jpg",
    "social_login": 1,
    "color1": "#0979ba",
    "color2": "#4CB050",
    "color3": "#9FECBE",
    "color4": "#FF9700",
    "color5": "#FAD97A",
    "color6": "#FAF1E8"
  },
  "flutter_payment": {
    "gateway": "flutterwave",
    "public_key": "FLWPUBK-3acf3d8eb36b49e09f92b0a3aa598bec-X",
    "encryption_key": "d32ee24e2de3134d94fd3613"
  },
  "paystack_payment": {
    "gateway": "paystack",
    "public_key": "pk_live_20c0e30788a06575f7716882b6f23692202ee7e8",
    "encryption_key": "sk_live_3b9887039701fc97ba4aac0b2dd1f640aed7ea67"
  },
  "forms": {
    "sign_up": [
      {
        "title": "Register Now",
        "subtitle": "Signup with us and share our resources",
        "action": "user_mgts_register",
        "nwp_request": "nwp_dynamic_form",
        "fields": [
          {
            "name": "first_name",
            "field_label": "First Name",
            "form_field": "text",
            "required_field": 1,
            "validation_message": "Please provide the right information"
          }
        ]
      }
    ],
    "sign_in": {
      "title": "Sign In",
      "subtitle": "Sign-in and enjoy yourself",
      "action": "user_mgt_login",
      "nwp_request": "nwp_dynamic_form",
      "fields": [
        {
          "name": "email",
          "field_label": "Email",
          "form_field": "email",
          "required_field": 1,
          "validation_message": "Please provide your email address",
          "note": "",
          "min": 0,
          "max": 50
        }
      ]
    },
    "profile_update": {
      "title": "Profile Update",
      "subtitle": "Update your profile & other info",
      "action": "user_mgt_update_profile",
      "nwp_request": "nwp_dynamic_form",
      "fields": [
        {
          "name": "first_name",
          "field_label": "First Name",
          "form_field": "text",
          "required_field": 1,
          "validation_message": "Please provide the right information"
        }
      ]
    },
    "reset_password": {
      "title": "Reset Password",
      "subtitle": "Reset your password",
      "action": "user_mgt_reset",
      "nwp_request": "nwp_dynamic_form",
      "fields": [
        {
          "name": "email",
          "field_label": "Email",
          "form_field": "email",
          "required_field": 1,
          "validation_message": "Please provide your email address",
          "note": "",
          "min": 0,
          "max": 50
        }
      ]
    }
  }
} 
*/

  String? endPoint1;
  String? endPoint2;
  String? endPoint3;
  String? privateKey;
  String? agoraApiKey;
  EndPointEntityDataClient? client;
  EndPointEntityDataFlutterPayment? flutterPayment;
  EndPointEntityDataPaystackPayment? paystackPayment;
  EndPointEntityDataForms? forms;

  EndPointEntityData({
    this.endPoint1,
    this.endPoint2,
    this.endPoint3,
    this.privateKey,
    this.agoraApiKey,
    this.client,
    this.flutterPayment,
    this.paystackPayment,
    this.forms,
  });
  EndPointEntityData.fromJson(Map<String, dynamic> json) {
    endPoint1 = json['end_point1']?.toString();
    endPoint2 = json['end_point2']?.toString();
    endPoint3 = json['end_point3']?.toString();
    privateKey = json['private_key']?.toString();
    agoraApiKey = json['agora_api_key']?.toString();
    client = (json['client'] != null)
        ? EndPointEntityDataClient.fromJson(json['client'])
        : null;
    flutterPayment = (json['flutter_payment'] != null)
        ? EndPointEntityDataFlutterPayment.fromJson(json['flutter_payment'])
        : null;
    paystackPayment = (json['paystack_payment'] != null)
        ? EndPointEntityDataPaystackPayment.fromJson(json['paystack_payment'])
        : null;
    forms = (json['forms'] != null)
        ? EndPointEntityDataForms.fromJson(json['forms'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['end_point1'] = endPoint1;
    data['end_point2'] = endPoint2;
    data['end_point3'] = endPoint3;
    data['private_key'] = privateKey;
    data['agora_api_key'] = agoraApiKey;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (flutterPayment != null) {
      data['flutter_payment'] = flutterPayment!.toJson();
    }
    if (paystackPayment != null) {
      data['paystack_payment'] = paystackPayment!.toJson();
    }
    if (forms != null) {
      data['forms'] = forms!.toJson();
    }
    return data;
  }
}

class EndPointEntity {
/*
{
  "type": 1,
  "msg": "Successful Initialization",
  "data": {
    "end_point1": "https://webapp.hyella.com.ng/demo/emr-v1.3/engine/api/",
    "end_point2": "",
    "end_point3": "",
    "private_key": "7aa2781285b5c85d34e96078039be80e",
    "agora_api_key": "f7921f7371364666a5ba490e82cfb935",
    "client": {
      "id": "101",
      "name": "Demo Hospital Ltd.",
      "tagline": "Home of maternity and safe delivery",
      "logo": "https://webapp.hyella.com.ng/demo/thealth/demo/logo.jpg",
      "social_login": 1,
      "color1": "#0979ba",
      "color2": "#4CB050",
      "color3": "#9FECBE",
      "color4": "#FF9700",
      "color5": "#FAD97A",
      "color6": "#FAF1E8"
    },
    "flutter_payment": {
      "gateway": "flutterwave",
      "public_key": "FLWPUBK-3acf3d8eb36b49e09f92b0a3aa598bec-X",
      "encryption_key": "d32ee24e2de3134d94fd3613"
    },
    "paystack_payment": {
      "gateway": "paystack",
      "public_key": "pk_live_20c0e30788a06575f7716882b6f23692202ee7e8",
      "encryption_key": "sk_live_3b9887039701fc97ba4aac0b2dd1f640aed7ea67"
    },
    "forms": {
      "sign_up": [
        {
          "title": "Register Now",
          "subtitle": "Signup with us and share our resources",
          "action": "user_mgts_register",
          "nwp_request": "nwp_dynamic_form",
          "fields": [
            {
              "name": "first_name",
              "field_label": "First Name",
              "form_field": "text",
              "required_field": 1,
              "validation_message": "Please provide the right information"
            }
          ]
        }
      ],
      "sign_in": {
        "title": "Sign In",
        "subtitle": "Sign-in and enjoy yourself",
        "action": "user_mgt_login",
        "nwp_request": "nwp_dynamic_form",
        "fields": [
          {
            "name": "email",
            "field_label": "Email",
            "form_field": "email",
            "required_field": 1,
            "validation_message": "Please provide your email address",
            "note": "",
            "min": 0,
            "max": 50
          }
        ]
      },
      "profile_update": {
        "title": "Profile Update",
        "subtitle": "Update your profile & other info",
        "action": "user_mgt_update_profile",
        "nwp_request": "nwp_dynamic_form",
        "fields": [
          {
            "name": "first_name",
            "field_label": "First Name",
            "form_field": "text",
            "required_field": 1,
            "validation_message": "Please provide the right information"
          }
        ]
      },
      "reset_password": {
        "title": "Reset Password",
        "subtitle": "Reset your password",
        "action": "user_mgt_reset",
        "nwp_request": "nwp_dynamic_form",
        "fields": [
          {
            "name": "email",
            "field_label": "Email",
            "form_field": "email",
            "required_field": 1,
            "validation_message": "Please provide your email address",
            "note": "",
            "min": 0,
            "max": 50
          }
        ]
      }
    }
  }
} 
*/

  int? type;
  String? msg;
  EndPointEntityData? data;

  EndPointEntity({
    this.type,
    this.msg,
    this.data,
  });
  EndPointEntity.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toInt();
    msg = json['msg']?.toString();
    data = (json['data'] != null)
        ? EndPointEntityData.fromJson(json['data'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['msg'] = msg;
    data['data'] = this.data?.toJson();
    return data;
  }
}

abstract class EndpointForms {
  final String? title;
  final String? subtitle;
  final String? action;
  final String? nwpRequest;
  final List<EndpointFormFields?>? fields;

  EndpointForms({
    this.title,
    this.subtitle,
    this.action,
    this.nwpRequest,
    this.fields,
  });
}

abstract class EndpointFormFields {
  String? name;
  String? fieldLabel;
  String? formField;
  int? requiredField;
  dynamic value;
  String? validationMessage;
  List<FormFieldOption?>? formFieldOptions;
  EndpointFormFields({
    this.name,
    this.fieldLabel,
    this.formField,
    this.requiredField,
    this.validationMessage,
    this.value,
    this.formFieldOptions,
  });

  Map<String, dynamic> toJson();
  EndpointFormFields.fromJson();
}
