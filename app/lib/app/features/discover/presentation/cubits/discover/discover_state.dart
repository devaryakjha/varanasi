// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discover_cubit.dart';

class DiscoverState extends Equatable {
  const DiscoverState({
    this.isLoading = false,
    this.blocks = const [],
  });

  final bool isLoading;
  final List<BlockModel> blocks;

  @override
  List<Object> get props => [
        isLoading,
        blocks,
      ];

  DiscoverState copyWith({
    bool? isLoading,
    List<BlockModel>? blocks,
  }) {
    return DiscoverState(
      isLoading: isLoading ?? this.isLoading,
      blocks: blocks ?? this.blocks,
    );
  }
}
