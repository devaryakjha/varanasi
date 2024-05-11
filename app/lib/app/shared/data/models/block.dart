import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi/app/shared/data/models/media.dart';
import 'package:varanasi/app/shared/domain/entities/block.dart';

part 'block.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BlockModel extends Equatable {
  const BlockModel({
    required this.title,
    required this.children,
    required this.sequence,
    required this.orientation,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) {
    return _$BlockModelFromJson(json);
  }

  final String title;
  final List<MediaModel> children;
  final int sequence;
  @JsonKey(unknownEnumValue: Axis.vertical, defaultValue: Axis.vertical)
  final Axis orientation;

  Block toEntity() {
    return Block(
      title: title,
      children: children.map((e) => e.toEntity()).toList(),
      sequence: sequence,
      orientation: orientation,
    );
  }

  Map<String, dynamic> toJson() {
    return _$BlockModelToJson(this);
  }

  @override
  List<Object?> get props => [title, children, sequence, orientation];
}
