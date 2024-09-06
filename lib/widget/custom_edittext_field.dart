import 'package:beta/theme/app_color.dart';
import 'package:beta/theme/app_size.dart';
import 'package:beta/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/regex_utils.dart';

class CustomEditTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final Color? labelBgColor;
  final Color? labelTextColor;
  final Color? fillColor;
  final String hintText;
  final double topPadding;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final double borderWidth;
  final double borderRadius;
  final int maxLength;
  final int? maxLine;
  final int? allowDecimalCount;
  final TextStyle style;
  final TextStyle? labelStyle;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Widget? errorWidget;
  final bool readOnly;
  final bool isRestrictSpecialChar;
  final bool isMobileNoRestricted;
  final bool isValueRestricted;
  final bool isNameRestricted;
  final bool isNumberRestricted;
  final bool isEmailRestricted;
  final bool isAllTextCapitalize;
  final bool enableInteractiveSelection;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitClick;
  final VoidCallback? onTapClick;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction textInputAction;

  const CustomEditTextField({
    super.key,
    required this.style,
    required this.onChanged,
    this.readOnly = false,
    this.labelText,
    this.labelBgColor,
    this.labelTextColor,
    this.labelStyle,
    required this.hintText,
    required this.controller,
    this.onTapClick,
    this.onSubmitClick,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.rightPadding = 0,
    this.leftPadding = 0,
    this.fillColor,
    this.isAllTextCapitalize = false,
    this.suffixWidget,
    this.prefixWidget,
    this.errorWidget,
    this.focusNode,
    this.borderWidth = 1,
    this.borderRadius = 8,
    this.maxLength = 100,
    this.maxLine = 1,
    this.allowDecimalCount = 2,
    this.isNameRestricted = false,
    this.isEmailRestricted = false,
    this.isRestrictSpecialChar = false,
    this.isMobileNoRestricted = false,
    this.isValueRestricted = false,
    this.isNumberRestricted = false,
    this.inputFormatter,
    this.enableInteractiveSelection = true,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding.w, right: rightPadding.w, top: topPadding.h, bottom: bottomPadding.h),
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 7.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onTap:  onTapClick,
              focusNode: focusNode,
              readOnly: readOnly,
              maxLines: maxLine,
              maxLength: maxLength,
              cursorColor: AppColors.cursorColor,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              textCapitalization: isAllTextCapitalize ? TextCapitalization.characters : TextCapitalization.sentences,
              obscureText: false,
              controller: controller,
              style: style,
              keyboardType: isNameRestricted
                  ? TextInputType.name
                  : isMobileNoRestricted
                  ? TextInputType.number
                  : isValueRestricted
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : isNumberRestricted
                  ? TextInputType.number
                  : isEmailRestricted
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              inputFormatters: inputFormatter ??

                  (isNameRestricted
                      ? [FilteringTextInputFormatter.allow(RegexUtils.alphabeticCharacters)]
                      : isRestrictSpecialChar
                      ? [FilteringTextInputFormatter.allow(RegexUtils.specialCharactersRestriction)]
                      : isMobileNoRestricted
                      ? [FilteringTextInputFormatter.allow(RegexUtils.number), LengthLimitingTextInputFormatter(10)]
                      : isValueRestricted
                      ? [ FilteringTextInputFormatter.allow(RegexUtils.decimalRestriction(allowDecimalCount ?? 2))]
                      : isNumberRestricted
                      ? [FilteringTextInputFormatter.allow(RegexUtils.number)]
                      : isEmailRestricted
                      ? [FilteringTextInputFormatter.allow(RegexUtils.email)]
                      : []),
              textInputAction: textInputAction,
              enableInteractiveSelection: enableInteractiveSelection,
              onChanged: (val) {
                if (val.isNotEmpty && val.startsWith(' ')) {
                  // Prevent space in input
                  controller?.text = val.trimLeft();
                  controller?.selection = TextSelection.fromPosition(TextPosition(offset: val.trimLeft().length));
                } else if (isMobileNoRestricted && !RegexUtils.mobileNumber.hasMatch(val)) {
                  // Prevent invalid mobile number input
                  controller?.value = const TextEditingValue(text: '', selection: TextSelection.collapsed(offset: 0));
                } else if (isValueRestricted && (val.startsWith('0') || val.startsWith(' '))) {
                  // Prevent 0 in starting input
                  controller?.value = const TextEditingValue(text: '', selection: TextSelection.collapsed(offset: 0));
                }
                if(onChanged != null){
                  onChanged!(val);
                }
              },
              onSubmitted: (val) {
                if (onSubmitClick != null) {
                  onSubmitClick!(val);
                }
              },
              decoration: InputDecoration(
                  filled: fillColor != null ? true : false,
                  fillColor: fillColor ?? Colors.transparent,
                  counterText: "",
                  focusColor: Colors.transparent,
                  hintText: hintText,
                  hintStyle: AppTextStyle.regular400(color: AppColors.hintTextColor, fontSize: AppSize.fontSize14),
                  prefixIcon: prefixWidget,
                  suffixIcon: suffixWidget,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: errorWidget != null ? AppColors.editTextRequiredLabelColor : AppColors.editTextBorderColor, width: borderWidth.w),
                      borderRadius: BorderRadius.circular(borderRadius.r)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: errorWidget != null ? AppColors.editTextRequiredLabelColor : AppColors.editTextBorderColor, width: borderWidth.w),
                    borderRadius: BorderRadius.circular(borderRadius.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: errorWidget != null ? AppColors.editTextRequiredLabelColor : AppColors.editTextBorderColor, width: borderWidth.w),
                    borderRadius: BorderRadius.circular(borderRadius.r),
                  )),
            ),
            if (errorWidget != null) errorWidget!,
          ],
        ),
      ),
    );
  }
}
