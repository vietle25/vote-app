import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';

class NumericStepInput extends StatefulWidget {
  final int minValue; // Min value
  final int maxValue; // Max value
  final double? maxWidth; // Max width text input
  final double? minWidth; // Min width text input
  final EdgeInsets? paddingTextInput; // Padding text field
  final int? viewType; // View type
  final ValueChanged<int>? onChanged;
  String? initValueQuantity;
  bool? isAddCard;

  NumericStepInput({
    Key? key,
    this.minValue = 1,
    this.maxValue = 10000,
    this.onChanged,
    this.viewType,
    this.minWidth,
    this.maxWidth,
    this.paddingTextInput,
    this.initValueQuantity = "1",
    this.isAddCard: false,
  }) : super(key: key);

  @override
  State<NumericStepInput> createState() {
    return _NumericStepInputState();
  }
}

class _NumericStepInputState extends State<NumericStepInput> {
  late int counter;
  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController =
        TextEditingController(text: widget.initValueQuantity);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.isAddCard ?? false) {
    //   FocusScope.of(context).requestFocus(FocusNode());
    //   setState(() {
    //     textEditingController.text = "1";
    //     widget.isAddCard = false;
    //   });
    // }
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue50,
        borderRadius: BorderRadius.circular(Constants.cornerRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          renderButton(
            icon: Icons.remove_rounded,
            onPress: () {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                if (int.parse(this.textEditingController.text) >
                    widget.minValue) {
                  this.textEditingController.text =
                      (int.parse(this.textEditingController.text) - 1)
                          .toString();
                  widget.onChanged!(int.parse(this.textEditingController.text));
                }
              });
            },
            right: false,
          ),
          Container(
            padding: widget.paddingTextInput ?? EdgeInsets.zero,
            constraints: BoxConstraints(
              maxWidth: widget.maxWidth ?? 45,
              minWidth: widget.minWidth ?? 20,
            ),
            margin: EdgeInsets.symmetric(horizontal: Constants.margin),
            child: TextFormField(
                enabled: false,
                textAlign: TextAlign.center,
                style: CommonStyle.textBold(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0.0),
                  isDense: true,
                  counterText: '',
                ),
                keyboardType: TextInputType.number,
                // inputFormatters: [
                //   // FilteringTextInputFormatter.digitsOnly,
                //   FilteringTextInputFormatter.allow(RegExp(
                //       r'^(?:[1-9][0-9]{3}|[1-9][0-9]{2}|[1-9][0-9]|[1-9])$')),
                // ],
                maxLines: 1,
                maxLength: 4,
                controller: textEditingController,
                onChanged: (txt) {
                  if (!Utils.isNull(txt)) widget.onChanged!(int.parse(txt));
                },
                onFieldSubmitted: (value) {
                  if (value.length > 0) {
                    widget.onChanged!(int.parse(value));
                  }
                  if (this.textEditingController.text.length == 0) {
                    this.textEditingController.text =
                        widget.minValue.toString();
                  }
                }),
          ),
          renderButton(
            icon: Icons.add_rounded,
            onPress: () {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                if (int.parse(this.textEditingController.text) <
                    widget.maxValue) {
                  this.textEditingController.text =
                      (int.parse(this.textEditingController.text) + 1)
                          .toString();
                  widget.onChanged!(int.parse(this.textEditingController.text));
                }
              });
            },
            right: true,
          ),
        ],
      ),
    );
  }

  Widget renderButton(
      {required IconData icon, required bool right, Function? onPress}) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {onPress!()},
          child: Padding(
            padding: EdgeInsets.all(Constants.padding8),
            child: Icon(
              icon,
              size: 24,
              color: Colors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
