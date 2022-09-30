import 'package:flutter_app/controllers/base_controller.dart';
import 'package:flutter_app/models/singer/singer_filter.dart';
import 'package:flutter_app/models/singer/singer_model.dart';
import 'package:flutter_app/models/user/user_device_model.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_app/utils/storage_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:get/get.dart';

class SingerDetailController extends BaseController {
  final UserRepository _userRepository = UserRepository.getInstance();
  var data = SingerModel(id: 0, name: '').obs;
  var voucher = ''.obs;
  var arguments = Get.arguments;
  int singerId = 0;

  @override
  void onInit() {
    super.onInit();
    singerId = arguments['singerId'];
    saveDevice();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> handlerRefresh({bool isCountUncensored = true}) async {}

  saveDevice() async {
    SingerFilter filter = SingerFilter(
      deviceId: Globals.userDevice.deviceId,
      singerId: singerId,
    );

    this.showLoading();
    await _userRepository.getSingerDetail(filter).then((res) async {
      if (res.isSuccessful) {
        var data = res.body!.data;
        if (!Utils.isNull(data)) {
          Globals.userDevice = UserDeviceModel.fromJson(data);
          StorageUtil.storeItem(StorageUtil.userDevice, data);
        } else {
          var errorCode = res.body!.errorCode;
          handleError(errorCode);
        }
        this.closeLoading();
      } else {
        var errorCode = res.body!.errorCode;
        handleError(errorCode);
      }
    }).catchError((Object obj) {
      handleNetWorkError(obj);
    });
  }
}
