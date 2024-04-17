import 'package:equatable/equatable.dart';
import 'package:varanasi/app/shared/domain/entities/block.dart';

class DiscoveryData extends Equatable {
  const DiscoveryData({required this.blocks});

  const DiscoveryData.empty() : blocks = const [];

  final List<Block> blocks;

  @override
  List<Object?> get props => [blocks];
}
