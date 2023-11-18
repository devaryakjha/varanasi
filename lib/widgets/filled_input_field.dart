part of 'input_field.dart';

class FilledInputField extends InputFormField {
  FilledInputField({
    super.key,
    super.controller,
    super.initialValue,
    super.focusNode,
    InputDecoration decoration = const InputDecoration(),
    super.keyboardType,
    super.textCapitalization = TextCapitalization.none,
    super.textInputAction,
    super.style,
    super.strutStyle,
    super.textDirection,
    super.textAlign,
    super.textAlignVertical,
    super.autofocus,
    super.readOnly,
    super.toolbarOptions,
    super.showCursor,
    super.obscuringCharacter = '•',
    super.obscureText,
    super.autocorrect,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions,
    super.maxLengthEnforcement,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.scrollController,
    super.enableIMEPersonalizedLearning,
    super.mouseCursor,
    super.restorationId,
    super.onSaved,
    super.validator,
    super.inputType,
    required BuildContext context,
    bool noBorder = false,
  }) : super(
          decoration: filledInputDecorationMedium(
            context,
            decoration: decoration,
          ),
        );
}

InputDecoration filledInputDecorationMedium(
  BuildContext context, {
  InputDecoration? decoration,
  bool noBorder = false,
}) {
  return (decoration ?? const InputDecoration()).copyWith(
    filled: true,
    isDense: true,
    focusedBorder: noBorder
        ? null
        : OutlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.primary),
          ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
