// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi/app/features/discover/domain/entities/discovery_data.dart';
import 'package:varanasi/app/shared/data/models/block.dart';

part 'discovery_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DiscoveryDataModel extends Equatable {
  const DiscoveryDataModel({required this.blocks});

  const DiscoveryDataModel.empty() : blocks = const [];

  final List<BlockModel> blocks;

  DiscoveryDataModel copyWith({
    List<BlockModel>? blocks,
  }) {
    return DiscoveryDataModel(
      blocks: blocks ?? this.blocks,
    );
  }

  factory DiscoveryDataModel.fromJson(Map<String, dynamic> json) =>
      _$DiscoveryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoveryDataModelToJson(this);

  DiscoveryData toEntity() {
    return DiscoveryData(
      blocks: blocks.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [blocks];
}
