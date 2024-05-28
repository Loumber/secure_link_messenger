import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:secure_link_messenger/src/app/di.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/entities/searched_user_entity.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(InitialFriends()) {
    on<SearchFriendEvent>((event, emit) async {
      emit(SearchFriends());
      var contacts =
          await MyLocator.contactsRepository.searchContacts(event.nameUser,event.friends);
      emit(SearchedFriends(contacts));
    });
    on<MyFriendEvent>((event,emit){
      emit(InitialFriends());
    });
  }
}
