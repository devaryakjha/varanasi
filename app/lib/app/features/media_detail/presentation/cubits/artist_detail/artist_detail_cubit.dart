import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'artist_detail_state.dart';

class ArtistDetailCubit extends Cubit<ArtistDetailState> {
  ArtistDetailCubit() : super(ArtistDetailInitial());
}
