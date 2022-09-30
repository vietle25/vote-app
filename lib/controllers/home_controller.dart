import 'package:flutter/cupertino.dart';
import 'package:flutter_app/controllers/base_controller.dart';
import 'package:flutter_app/models/common/device_model.dart';
import 'package:flutter_app/models/common/paging_model.dart';
import 'package:flutter_app/models/singer/singer_filter.dart';
import 'package:flutter_app/models/singer/singer_model.dart';
import 'package:flutter_app/models/user/user_device_model.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_app/utils/storage_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:flutter_app/widgets/dialog_voucher_widget.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final UserRepository _userRepository = UserRepository.getInstance();
  var data = List.generate(10, (index) {
    return SingerModel(id: 1, name: "Sơn Tùng MTP");
  }).obs;
  var voucher = ''.obs;

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
    saveDevice();
    getVoucherStorage();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> handlerRefresh({bool isCountUncensored = true}) async {}

  saveDevice() async {
    String? token = await getDeviceToken();
    String? firebaseToken = await getFirebaseToken();
    DeviceModel model = DeviceModel(
      deviceId: token ?? "",
      deviceToken: firebaseToken,
    );

    this.showLoading();
    await _userRepository.saveUserDevice(model).then((res) async {
      if (res.isSuccessful) {
        var data = res.body!.data;
        if (!Utils.isNull(data)) {
          Globals.userDevice = UserDeviceModel.fromJson(data);
          StorageUtil.storeItem(StorageUtil.userDevice, data);
          getListSinger();
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

  getListSinger() async {
    this.showLoading();
    SingerFilter filter = SingerFilter(
      paging: PagingModel(page: 0, pageSize: 500),
    );
    await _userRepository.getAllSingers(filter).then((res) async {
      if (res.isSuccessful) {
        var dataRes = res.body!.data;
        if (!Utils.isNull(data) && dataRes['data'] is List) {
          data.clear();
          dataRes['data']
              .forEach((el) => this.data.add(SingerModel.fromJson(el)));
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

  getVoucherStorage() async {
    String? value = await StorageUtil.retrieveItem(StorageUtil.voucher);
    voucher.value = value ?? "";
    if (Utils.isNull(value)) {
      showDialogVoucher();
    }
  }

  showDialogVoucher() async {
    await Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: DialogVoucherWidget(
          onConfirm: (value) {
            print("Value" + value);
          },
        ),
      ),
      barrierDismissible: false,
    );
  }
}
