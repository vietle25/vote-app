import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/enums/enums.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';

import 'button_widget.dart';

export 'package:flutter/services.dart' show SmartQuotesType, SmartDashesType;

class TextFieldWidget extends FormField<String> {
  TextFieldWidget({
    Key? key,
    required this.controller,
    EdgeInsetsGeometry? padding,
    String? initialValue,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    @Deprecated('Use autoValidateMode parameter which provide more specific '
        'behaviour related to auto validation. '
        'This feature was deprecated after v1.19.0.')
        bool autovalidate = false,
    bool maxLengthEnforced = true,
    this.maxLines = 1,
    int? minLines,
    bool expands = false,
    this.maxLength,
    ValueChanged<String>? onChanged,
    this.onTap,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autoValidateMode,
    this.containerColor = Colors.transparent,
    this.margin = const EdgeInsets.symmetric(
      horizontal: Constants.margin16,
      vertical: Constants.margin8,
    ),
    this.radius: Constants.cornerRadius,
    String? labelText,
    Widget? prefixIcon,
    Widget? prefixWidget,
    this.suffixIcon,
    this.onFocus,
    String? hintText,
    Function? onTapPrefix,
    this.onTapSuffix,
    bool alignLabelWithHint = false,
    this.containerDecoration,
  })  : assert(initialValue == null || controller == null),
        assert(obscuringCharacter.length == 1),
        assert(
            autovalidate == false ||
                autovalidate == true && autoValidateMode == null,
            'autovalidate and autoValidateMode should not be used together.'),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength > 0),
        super(
          key: key,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          enabled: enabled ?? decoration?.enabled ?? true,
          autovalidateMode: autovalidate
              ? AutovalidateMode.always
              : (autoValidateMode ?? AutovalidateMode.disabled),
          builder: (FormFieldState<String> field) {
            final _TextFieldWidgetState state = field as _TextFieldWidgetState;
            final InputDecoration effectiveDecoration;
            if (decoration != null) {
              effectiveDecoration = decoration;
            } else {
              effectiveDecoration = InputDecoration(
                labelText: labelText ?? null,
                labelStyle: CommonStyle.text(color: Colors.textLabel),
                contentPadding: padding ??
                    EdgeInsets.only(
                      left: !Utils.isNull(prefixIcon) ? 0 : Constants.padding16,
                      right:
                          !Utils.isNull(suffixIcon) ? 0 : Constants.padding16,
                      top: state.focusNode.hasFocus ||
                              (!Utils.isNull(state._effectiveController) &&
                                  state._effectiveController.text.isNotEmpty)
                          ? Utils.isNull(labelText)
                              ? Constants.padding12
                              : Constants.padding8
                          : alignLabelWithHint
                              ? 0
                              : Constants.padding12,
                      bottom: Utils.isNull(labelText)
                          ? Constants.padding12
                          : Constants.padding8,
                    ),
                isDense: true,
                hintText: hintText ?? "",
                prefixIcon: !Utils.isNull(prefixIcon)
                    ? ButtonWidget(
                        color: Colors.transparent,
                        type: ButtonType.iconButton,
                        child: prefixIcon!,
                        onTap: () {
                          state.focusNode.unfocus();
                          onTapPrefix!();
                        },
                        margin:
                            EdgeInsets.symmetric(horizontal: Constants.margin8),
                        padding: EdgeInsets.zero,
                      )
                    : null,
                prefixIconConstraints:
                    BoxConstraints(maxHeight: 36, minHeight: 28),
                prefix: prefixWidget,
                hintStyle: CommonStyle.text(
                  color: Colors.grey400,
                ),
                border: InputBorder.none,
                alignLabelWithHint: alignLabelWithHint,
                counterText: !Utils.isNull(controller) &&
                        !Utils.isNull(maxLength) &&
                        maxLines! > 1
                    ? '${controller!.text.length}/$maxLength'
                    : "",
              );
            }
            effectiveDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            return TextField(
              controller: state._effectiveController,
              focusNode: state.focusNode,
              decoration: effectiveDecoration.copyWith(
                  // labelText: field.errorText,
                  // labelStyle: CommonStyle.textMedium(
                  //   color: Utils.isNull(field.errorText)
                  //       ? Colors.textLabel
                  //       : Colors.red,
                  // ),
                  ),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              toolbarOptions: toolbarOptions,
              readOnly: readOnly,
              showCursor: showCursor,
              obscuringCharacter: obscuringCharacter,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType ??
                  (obscureText
                      ? SmartDashesType.disabled
                      : SmartDashesType.enabled),
              smartQuotesType: smartQuotesType ??
                  (obscureText
                      ? SmartQuotesType.disabled
                      : SmartQuotesType.enabled),
              enableSuggestions: enableSuggestions,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              onChanged: onChangedHandler,
              onEditingComplete: onEditingComplete,
              onSubmitted: onFieldSubmitted,
              inputFormatters: inputFormatters,
              enabled: enabled ?? decoration?.enabled ?? true,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              scrollPadding: scrollPadding,
              scrollPhysics: scrollPhysics,
              keyboardAppearance: keyboardAppearance,
              enableInteractiveSelection: enableInteractiveSelection,
              buildCounter: buildCounter,
              autofillHints: autofillHints,
            );
          },
        );

  final TextEditingController? controller; // Controls the text being edited.
  final Color? containerColor; // Container color
  final double? radius; // Border radius
  final EdgeInsets? margin; // Margin text field
  final Decoration? containerDecoration; // Container decoration
  final Function? onFocus; // On focus
  final Widget? suffixIcon; // Suffix Icon
  final Function? onTapSuffix; // On tap suffix
  final GestureTapCallback? onTap; // On tap
  final int? maxLength; // Max length
  final int? maxLines; // Max lines

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends FormFieldState<String> {
  late TextEditingController _controller;
  late FocusNode _focusNode; // Focus Node

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  FocusNode get focusNode => _focusNode;

  @override
  TextFieldWidget get widget => super.widget as TextFieldWidget;

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  /// On focus node event
  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
    if (!Utils.isNull(widget.onFocus) && _focusNode.hasFocus) widget.onFocus!();
  }

  @override
  void didUpdateWidget(TextFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) _controller = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _focusNode.dispose();
    super.dispose();
  }

  // @override
  // void didChange(String value) {
  //   super.didChange(value);
  //
  //   if (_effectiveController.text != value) _effectiveController.text = value;
  // }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Material(
              child: InkWell(
                onTap: widget.onTap ?? null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: super.build(context),
                    ),
                    this.renderSuffixIcon(),
                    this.renderCounterText(),
                  ],
                ),
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius!),
                ),
              ),
              color: widget.containerColor ?? Colors.white,
              borderRadius: BorderRadius.circular(widget.radius!),
            ),
            padding: EdgeInsets.only(
              bottom: !Utils.isNull(widget.controller) &&
                      !Utils.isNull(widget.maxLength) &&
                      widget.maxLines! > 1
                  ? Constants.padding8
                  : 0,
            ),
            decoration: widget.containerDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius!),
                  border: Border.all(
                    color: Colors.background,
                    style: BorderStyle.solid,
                    width: Constants.borderWidth,
                  ),
                ),
          ),
          !Utils.isNull(this.errorText)
              ? Container(
                  margin: EdgeInsets.only(
                    top: Constants.margin8,
                    right: Constants.margin8,
                    left: Constants.margin8,
                  ),
                  child: Text(
                    this.errorText!,
                    style: CommonStyle.textError,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Container(),
        ],
      ),
      margin: widget.margin,
    );
  }

  /// Render suffix icon
  renderSuffixIcon() {
    if (!Utils.isNull(widget.suffixIcon)) {
      return ButtonWidget(
        type: ButtonType.iconButton,
        child: widget.suffixIcon!,
        color: Colors.transparent,
        margin: EdgeInsets.only(right: Constants.margin12),
        onTap: () {
          _focusNode.unfocus();
          if (!Utils.isNull(widget.onTapSuffix)) {
            widget.onTapSuffix!();
          } else {
            widget.onTap!();
          }
        },
      );
    } else
      return Container();
  }

  /// Render counter text
  renderCounterText() {
    if (!Utils.isNull(widget.controller) &&
        !Utils.isNull(widget.maxLength) &&
        widget.maxLines == 1) {
      return Container(
        margin: EdgeInsets.only(right: Constants.margin16),
        child: Text(
          '${widget.controller!.text.length}/${widget.maxLength}',
          style: CommonStyle.textSmall(color: Colors.textLight),
        ),
      );
    } else {
      return Container();
    }
  }

  /// Suppress changes that originated from within this class.
  void _handleControllerChanged() {
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}
