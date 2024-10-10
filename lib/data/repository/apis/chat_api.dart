import 'package:flutter/foundation.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/chat_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/upload_file_response_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

class ChatApi {
  bool isDoctor = Global.storageService.getAppUser()!.isStaff == 1;

  Future<ChatListResponseEntity> getConversations(String recieverId) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("app_list_of_doctors");
      String uri = "&public_key=$publicKey";
      if (isDoctor) {
        uri += "&nwp_request=msgs_get_convo&patient_id=$recieverId";
      } else {
        uri += "&nwp_request=msg_get_convo&doctor_id=$recieverId";
      }

      var response = await HttpUtil().post(uri);
      return ChatListResponseEntity.fromMap(response);
    } catch (e) {
      return ChatListResponseEntity(
        type: 0,
        msg: "Unable to get data at the moment, please try again later",
        data: null,
      );
    }
  }

  Future<ChatListResponseEntity> sendTextMessageToServer(
      String message, String chatKey, String receiverId) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("msg_save_msg");
      String uri = "&public_key=$publicKey";
      if (isDoctor) {
        uri += "&nwp_request=msg_save_d_msg";
      } else {
        uri += "&nwp_request=msg_save_msg";
      }
      /* print(
          {"message": message, "chat_key": chatKey, "receiver_id": receiverId}); */

      var response = await HttpUtil().post(uri, data: {
        "message": message,
        "chat_key": chatKey,
        "receiver_id": receiverId
      });

      if (kDebugMode) {
        print(response);
      }

      return ChatListResponseEntity(data: null, type: 0, msg: '');
    } catch (e) {
      return ChatListResponseEntity(
        type: 0,
        msg: "Unable to get data at the moment, please try again later",
        data: null,
      );
    }
  }

  Future<UploadFIleResponseEntity> sendChatFiles(
      {required Map<String, dynamic> files, receiverId}) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("file_upload");
      String uri = "&nwp_request=file_upload&public_key=$publicKey";
      Map<String, String> params = {
        'expiry_in_minutes': "30",
        'readonly': '1',
        'source': 'chat',
        'receiver_id': receiverId ?? "",
        'attachment_name': ''
      };

      var response =
          await HttpUtil().sendFiles(uri, files, queryParameters: params);
      return UploadFIleResponseEntity.fromJson(response);
    } catch (e) {
      return UploadFIleResponseEntity(
        type: 0,
        msg: 'An error occured',
        data: null,
      );
    }
  }

  deleteChat(chatKey) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("app_list_of_doctors");
      String uri =
          "&nwp_request=msg_del&public_key=$publicKey&chat_key=$chatKey";
      var response = await HttpUtil().post(uri);
      return print("Deleting $chatKey response: $response===============");
    } catch (e) {
      toastInfo(msg: "Error deleting chat");
    }
  }
}
