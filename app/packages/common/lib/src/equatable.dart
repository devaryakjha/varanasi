import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
abstract class Equatable {
  const Equatable();

  List<Object?> get props;

  bool? get stringify => false;

  @override
  int get hashCode => Object.hashAll(props);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Equatable &&
            runtimeType == other.runtimeType &&
            _equals(props, other.props);
  }

  @override
  String toString() {
    if (stringify ?? false) {
      return _mapPropsToString(runtimeType, props);
    }
    return '$runtimeType';
  }
}

/// A mixin that helps implement equality
/// without needing to explicitly override [operator ==] and [hashCode].
@immutable
mixin EquatableMixin {
  List<Object?> get props;

  bool? get stringify => null;

  @override
  int get hashCode => Object.hashAll(props);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EquatableMixin &&
            runtimeType == other.runtimeType &&
            _equals(props, other.props);
  }

  @override
  String toString() {
    if (stringify ?? false) {
      return _mapPropsToString(runtimeType, props);
    }
    return '$runtimeType';
  }
}

const DeepCollectionEquality _equality = DeepCollectionEquality();

/// Determines whether [list1] and [list2] are equal.
bool _equals(List<Object?>? list1, List<Object?>? list2) {
  if (identical(list1, list2)) return true;
  if (list1 == null || list2 == null) return false;
  final length = list1.length;
  if (length != list2.length) return false;

  for (var i = 0; i < length; i++) {
    final unit1 = list1[i];
    final unit2 = list2[i];

    if (_isEquatable(unit1) && _isEquatable(unit2)) {
      if (unit1 != unit2) return false;
    } else if (unit1 is Iterable || unit1 is Map) {
      if (!_equality.equals(unit1, unit2)) return false;
    } else if (unit1?.runtimeType != unit2?.runtimeType) {
      return false;
    } else if (unit1 != unit2) {
      return false;
    }
  }
  return true;
}

bool _isEquatable(Object? object) {
  return object is EquatableMixin;
}

/// Returns a string for [props].
String _mapPropsToString(Type runtimeType, List<Object?> props) {
  return '$runtimeType(${props.map((prop) => prop.toString()).join(', ')})';
}
