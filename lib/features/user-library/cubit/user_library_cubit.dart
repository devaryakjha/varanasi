import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_library_state.dart';

class UserLibraryCubit extends Cubit<UserLibraryState> {
  UserLibraryCubit() : super(UserLibraryInitial());
}
