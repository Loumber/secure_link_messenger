import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:secure_link_messenger/src/app/di.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/entities/searched_user_entity.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(InitialContacts()) {
    on<MyContactsEvent>((event, emit) async {
      emit(ShowMyContacts(await MyLocator.contactsRepository.getFriendList()));
    });

    on<SearchContactsEvent>((event, emit) async {
      emit(SearchContacts());
      if (event.nameUser.isNotEmpty) {
        List<SearchedUserEntity> searchedUser =
            await MyLocator.contactsRepository.searchUser(event.nameUser);
        emit(SearchedContacts(searchedUser));
      }
    });

    on<AddContactsEvent>((event, emit) {
      emit(SearchContacts());
    });
  }
}
