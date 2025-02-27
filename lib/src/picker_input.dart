part of flutterfullscreenpicker;

class PickerInput extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextInputType inputType;
  final TextEditingController? textController;
  final String label;
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool filled;
  final int? maxLines;
  final int minLines;
  final TextInputAction keyboardAction;
  final FocusNode? focusNode;
  final Function? validator;
  final Function? onSaved;
  final Function? onTap;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final Function? onEditComplete;
  final Color borderColor,
      enabledBorderColor,
      errorBorderColor,
      labelColor,
      textColor,
      fillColor,
      errorTextColor,
      hintTextColor;
  final bool showLabel;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final double borderRadius;

  PickerInput({
    required this.label,
    required this.hintText,
    this.initialValue,
    this.textController,
    this.inputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.filled = true,
    this.maxLines,
    this.minLines = 1,
    this.keyboardAction = TextInputAction.next,
    this.focusNode,
    this.validator,
    this.onSaved,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditComplete,
    this.borderColor = Colors.black,
    this.enabledBorderColor = Colors.transparent,
    this.errorBorderColor = Colors.red,
    this.labelColor = Colors.black,
    this.textColor = Colors.black,
    this.hintTextColor = Colors.black54,
    this.errorTextColor = Colors.red,
    this.fillColor = const Color(0xFFEBF1FF),
    this.showLabel = true,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.borderRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    double borderRad = minLines > 1 ? 10 : borderRadius;
    return TextFormField(
      initialValue: initialValue,
      textAlign: textAlign,
      decoration: minLines > 1
          ? InputDecoration.collapsed(
              hintText: hintText,
              enabled: enabled,
            ).copyWith(
              errorStyle: TextStyle(color: errorTextColor, fontSize: 14),
            )
          : InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelText: showLabel ? label : null,
              labelStyle: TextStyle(
                color: labelColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRad),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRad),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: errorBorderColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRad),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRad),
                ),
              ),
              filled: filled,
              hintStyle: TextStyle(
                color: hintTextColor,
              ),
              hintText: hintText,
              fillColor: fillColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              errorStyle: TextStyle(
                color: errorTextColor,
                fontSize: 14,
              ),
            ),
      style: textStyle ?? TextStyle(color: textColor),
      enabled: enabled,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: minLines > 1 ? TextInputType.multiline : inputType,
      textInputAction: keyboardAction,
      validator: validator as String? Function(String?)?,
      onSaved: onSaved as void Function(String?)?,
      focusNode: focusNode,
      onTap: onTap as void Function()?,
      onChanged: onChanged as void Function(String)?,
      onFieldSubmitted: onFieldSubmitted as void Function(String)?,
      controller: textController,
      onEditingComplete: onEditComplete as void Function()?,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
    );
  }
}
