part of 'artist_detail_cubit.dart';

sealed class ArtistDetailState extends Equatable {
  const ArtistDetailState();

  @override
  List<Object> get props => [];
}

final class ArtistDetailInitial extends ArtistDetailState {}
