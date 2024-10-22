import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(super.initialState);

  void updateUser(String username) {
    emit(state.copyWith(userName: username));
  }
}

class ProfileState extends Equatable {
  final String userName;

  const ProfileState({this.userName = ''});

  ProfileState copyWith({
    String? userName,
  }) {
    return ProfileState(userName: userName ?? this.userName);
  }

  @override
  List<Object?> get props => [userName];
}
//TODO: burayada bak 
//TODO: equatable i arastir