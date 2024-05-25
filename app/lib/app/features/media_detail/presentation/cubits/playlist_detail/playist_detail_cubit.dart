import 'package:bloc/bloc.dart';

part 'playist_detail_state.dart';

class PlayistDetailCubit extends Cubit<PlayistDetailState> {
  PlayistDetailCubit() : super(PlayistDetailInitial());
}
