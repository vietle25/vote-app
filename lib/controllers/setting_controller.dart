import 'package:flutter_app/configs/error_code.dart';
import 'package:flutter_app/controllers/base_controller.dart';
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/models/user/user_model.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_app/utils/storage_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:flutter_app/widgets/switch_widget.dart';
import 'package:get/get.dart';

class SettingController extends BaseController {
  UserRepository _userRepository =
      UserRepository.getInstance(); // User repository

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onLogout() {
    this.showDialogConfirm(
      content: Localizes.confirmLogout.tr,
      confirmText: Localizes.logout.tr,
      confirmAction: () {
        this.logout();
      },
      barrierDismissible: true,
      showIconClose: false,
      showOneButton: false,
    );
  }

  turnOffPin() async {
    var value = !(Globals.user.value.activePin ?? false);
    UserModel filter = UserModel(
      activePin: value,
    );

    this.showLoading();
    await _userRepository.updatePin(filter).then((res) async {
      this.closeLoading();
      if (res.isSuccessful) {
        var data = res.body!.data;
        if (data == ErrorCode.success) {
          this.navigatorPopOverlay();
          await this.getProfile();
        } else {
          this.showMessage(message: Localizes.processingErr.tr);
        }
      } else {
        var errorCode = res.body!.errorCode;
        handleError(errorCode);
      }
    }).catchError((Object obj) {
      handleNetWorkError(obj);
    });
  }

  Future<void> getProfile() async {
    await _userRepository.getProfile().then((res) async {
      if (res.isSuccessful) {
        var data = res.body!.data;
        if (!Utils.isNull(data)) {
          UserModel user = new UserModel.fromJson(data);
          Globals.user.value = user;
          Globals.user.refresh();
          StorageUtil.storeItem(StorageUtil.userProfile, data);
          if (user.activePin ?? false)
            SwitchWidget.globalKey.currentState?.turnOn();
          else
            SwitchWidget.globalKey.currentState?.turnOff();
        } else {
          var errorCode = res.body!.errorCode;
          handleError(errorCode);
        }
      } else {
        var errorCode = res.body!.errorCode;
        handleError(errorCode);
      }
    }).catchError((Object obj) {
      handleNetWorkError(obj);
    });
  }
}
