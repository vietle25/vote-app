import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:flutter_app/widgets/text_input_widget.dart';

class DialogVoucherWidget extends StatefulWidget {
  final Function onConfirm;

  DialogVoucherWidget({
    required this.onConfirm,
  });

  @override
  DialogVoucherWidgetState createState() => DialogVoucherWidgetState();
}

class DialogVoucherWidgetState extends State<DialogVoucherWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(Constants.padding16 * 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.cornerRadius),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Constants.padding12,
          horizontal: Constants.margin16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "MÃ BÌNH CHỌN",
              style: CommonStyle.textBold(),
            ),
            SizedBox(
              height: Constants.margin16,
            ),
            TextInputWidget(
                controller: controller, hintText: "Nhập mã bình chọn"),
            SizedBox(
              height: Constants.margin16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget(
                  color: Colors.primary,
                  titleStyle: CommonStyle.textBold(color: Colors.white),
                  title: "Nhập",
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                  onTap: () {
                    if (!Utils.isNull(controller.text))
                      widget.onConfirm(controller.text);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
