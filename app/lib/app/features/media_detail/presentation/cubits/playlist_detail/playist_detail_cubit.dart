import 'package:bloc/bloc.dart';

part 'playist_detail_state.dart';

final class PlaylistDetailCubit extends Cubit<PlayistDetailState> {
  PlaylistDetailCubit() : super(PlayistDetailInitial());
}
