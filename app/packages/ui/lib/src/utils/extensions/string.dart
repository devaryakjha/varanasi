extension StringExtension on String? {
  /// Returns `true` if the string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if the string is not null or empty.
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Returns `true` if the string is null or whitespace.
  bool get isNullOrWhiteSpace => this == null || this!.trim().isEmpty;

  /// Returns `true` if the string is not null or whitespace.
  bool get isNotNullOrWhiteSpace => !isNullOrWhiteSpace;

  /// Returns the string if it is not null or empty,
  /// otherwise returns the [defaultValue].
  String orDefault(String defaultValue) => isNullOrEmpty ? defaultValue : this!;

  /// Returns the string if it is not null or whitespace,
  /// otherwise returns the [defaultValue].
  String orDefaultWhiteSpace(String defaultValue) =>
      isNullOrWhiteSpace ? defaultValue : this!;

  /// Returns the string if it is not null or empty,
  /// otherwise returns the [defaultValue].
  String? orDefaultNullable(String? defaultValue) =>
      isNullOrEmpty ? defaultValue : this;

  /// Returns the string if it is not null or whitespace,
  /// otherwise returns the [defaultValue].
  String? orDefaultWhiteSpaceNullable(String? defaultValue) =>
      isNullOrWhiteSpace ? defaultValue : this;

  /// Returns the string if it is not null or empty, otherwise
  /// returns the result of the [defaultValue] function.
  String orDefaultFunc(String Function() defaultValue) =>
      isNullOrEmpty ? defaultValue() : this!;

  /// Returns the string if it is not null or whitespace, otherwise
  /// returns the result of the [defaultValue] function.
  String orDefaultWhiteSpaceFunc(String Function() defaultValue) =>
      isNullOrWhiteSpace ? defaultValue() : this!;

  /// Returns the string if it is not null or empty, otherwise returns the
  /// result of the [defaultValue] function.
  String? orDefaultNullableFunc(String? Function() defaultValue) =>
      isNullOrEmpty ? defaultValue() : this;

  /// Returns the string if it is not null or whitespace, otherwise returns the
  /// result of the [defaultValue] function.
  String? orDefaultWhiteSpaceNullableFunc(String? Function() defaultValue) =>
      isNullOrWhiteSpace ? defaultValue() : this;

  /// Returns the string if it is not null or empty,
  /// otherwise returns an empty string.
  String orEmpty() => orDefault('');

  /// Returns the string if it is not null or whitespace,
  /// otherwise returns an empty string.
  String orWhiteSpace() => orDefaultWhiteSpace('');
}
