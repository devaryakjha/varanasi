import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi/app/features/media_detail/domain/entities/artist_bio.dart';

part 'artist_bio.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BioModel extends Equatable {
  const BioModel({
    required this.sequence,
    required this.text,
    required this.title,
  });

  factory BioModel.fromJson(Map<String, dynamic> json) =>
      _$BioModelFromJson(json);

  final int sequence;
  final String text;
  final String title;

  Map<String, dynamic> toJson() => _$BioModelToJson(this);

  Bio toEntity() => Bio(
        sequence: sequence,
        text: text,
        title: title,
      );

  @override
  List<Object?> get props => [sequence, text, title];
}
