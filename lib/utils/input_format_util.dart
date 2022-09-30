import 'package:flutter/services.dart';
import 'package:flutter_app/utils/string_util.dart';

class InputFormatUtil {
  // static SpaceInputFormatter space() {
  //   return SpaceInputFormatter();
  // }

  static UpperInputFormatter upper() {
    return UpperInputFormatter();
  }
}

class SpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    String oldText = oldValue.text;
    var step = 4;
    int newStep = 0;
    var offset = newValue.selection.baseOffset;
    newText = newText.replaceAll(" ", '');
    String updateText = StringUtil.insertCharAfter(newText);
    print(updateText.indexOf("  "));

    if (newValue.text.length > (step + 1) * 4 - 1 ||
        int.tryParse(updateText.replaceAll(" ", '')) == null ||
        updateText.indexOf("  ") != -1) {
      //truong hop qua so ky tu cho phep
      //truong hop them ky tu dac biet thi ko cho phep them -- chuyen int kiem tra
      updateText = oldText;
      newStep--;
    } else if (oldText.length == updateText.length) {
      //truong hop xoa ky tu dac biet them vao => bỏ qua
    } else if (newText != "") {
      if (updateText.length >= newValue.text.length &&
          offset % (step + 1) == 0 &&
          oldText.length <= newValue.text.length)
        //truong hop them ky tu nhung o vi tri se them ky tu dac biet => offset+1
        newStep++;
      else if (updateText.length < newValue.text.length &&
          newValue.selection.baseOffset > 0)
        newStep--;
      else if (oldText.length > newValue.text.length) newStep--;
      // print("newStep: " + newStep.toString());
      // if (oldText.length == updateText.length) newStep--;
    }
    print("");
    print(oldText);
    print(newValue.text);
    print(updateText);
    print(newStep);
    print(offset);
    return TextEditingValue(
      text: updateText,
      selection: TextSelection.collapsed(offset: offset + newStep),
    );
  }
}

class UpperInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    return TextEditingValue(
      text: StringUtil.upperAfterSpaceString(newText),
      selection: TextSelection.collapsed(offset: newValue.selection.baseOffset),
    );
  }
}
