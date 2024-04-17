// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discover_cubit.dart';

class DiscoverState extends Equatable {
  const DiscoverState({
    this.isLoading = false,
    this.discoveryData = const DiscoveryData.empty(),
  });

  final bool isLoading;
  final DiscoveryData discoveryData;

  @override
  List<Object> get props => [
        isLoading,
        discoveryData,
      ];

  DiscoverState copyWith({
    bool? isLoading,
    DiscoveryData? discoveryData,
  }) {
    return DiscoverState(
      isLoading: isLoading ?? this.isLoading,
      discoveryData: discoveryData ?? this.discoveryData,
    );
  }
}
