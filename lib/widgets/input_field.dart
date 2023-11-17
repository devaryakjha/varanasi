import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/input_validators.dart';

part 'filled_input_field.dart';

class InputFormField extends TextFormField {
  InputFormField({
    super.key,
    super.controller,
    super.initialValue,
    super.focusNode,
    super.decoration = const InputDecoration(),
    super.keyboardType,
    super.textCapitalization = TextCapitalization.none,
    super.textInputAction,
    super.style,
    super.strutStyle,
    super.textDirection,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.autofocus = false,
    super.readOnly = false,
    super.toolbarOptions,
    super.showCursor,
    super.obscuringCharacter = '•',
    bool? obscureText,
    super.autocorrect = false,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLengthEnforcement,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.enableInteractiveSelection,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.scrollController,
    super.enableIMEPersonalizedLearning = true,
    super.mouseCursor,
    super.restorationId,
    super.onSaved,
    InputValidator? validator,
    InputType inputType = InputType.none,
  }) : super(
            validator: validator ?? _getInputValidator(inputType),
            obscureText: obscureText ?? inputType == InputType.password);

  InputFormField.custom({
    super.key,
    InputFieldSize size = InputFieldSize.medium,
    InputDecoration? decoration,
    super.controller,
    super.initialValue,
    super.focusNode,
    TextInputType? keyboardType,
    super.textCapitalization = TextCapitalization.none,
    super.textInputAction,
    super.style,
    super.strutStyle,
    super.textDirection,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.autofocus = false,
    super.readOnly = false,
    super.toolbarOptions,
    super.showCursor,
    super.obscuringCharacter = '•',
    bool? obscureText,
    super.autocorrect = false,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLengthEnforcement,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.enableInteractiveSelection,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.scrollController,
    super.enableIMEPersonalizedLearning = true,
    super.mouseCursor,
    super.restorationId,
    super.onSaved,
    InputValidator? validator,
    InputType inputType = InputType.none,
  }) : super(
          validator: validator ?? _getInputValidator(inputType),
          keyboardType: keyboardType ?? _getTextInputType(inputType),
          obscureText: obscureText ?? inputType == InputType.password,
          decoration: size == InputFieldSize.medium
              ? inputDecorationMedium(decoration ?? const InputDecoration())
              : inputDecorationSmall(decoration ?? const InputDecoration()),
        );
  InputFormField.small({
    super.key,
    InputDecoration? decoration,
    super.controller,
    super.initialValue,
    super.focusNode,
    TextInputType? keyboardType,
    super.textCapitalization = TextCapitalization.none,
    super.textInputAction,
    super.style,
    super.strutStyle,
    super.textDirection,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.autofocus = false,
    super.readOnly = false,
    super.toolbarOptions,
    super.showCursor,
    super.obscuringCharacter = '•',
    bool? obscureText,
    super.autocorrect = false,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLengthEnforcement,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.enableInteractiveSelection,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.scrollController,
    super.enableIMEPersonalizedLearning = true,
    super.mouseCursor,
    super.restorationId,
    super.onSaved,
    InputValidator? validator,
    InputType inputType = InputType.none,
  }) : super(
          validator: validator ?? _getInputValidator(inputType),
          keyboardType: keyboardType ?? _getTextInputType(inputType),
          obscureText: obscureText ?? inputType == InputType.password,
          decoration:
              inputDecorationSmall(decoration ?? const InputDecoration()),
        );
}

enum InputFieldSize { medium, small }

enum InputType { email, password, none, username }

InputDecoration inputDecorationMedium(InputDecoration decoration) {
  return decoration.copyWith();
}

InputDecoration inputDecorationSmall(InputDecoration decoration) {
  return decoration.copyWith(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  );
}

TextInputType? _getTextInputType(InputType inputType) {
  switch (inputType) {
    case InputType.password:
      return TextInputType.visiblePassword;
    case InputType.email:
      return TextInputType.emailAddress;
    case InputType.username:
      return TextInputType.name;
    default:
      return null;
  }
}

typedef InputValidator = String? Function(String? value);

InputValidator? _getInputValidator(InputType inputType) => switch (inputType) {
      InputType.email => InputValidators.validateEmail,
      InputType.password => InputValidators.validatePassword,
      _ => null,
    };
