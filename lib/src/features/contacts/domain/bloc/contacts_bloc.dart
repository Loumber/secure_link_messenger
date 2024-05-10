import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ShowMyContacts()) {
    on<MyContactsEvent>((event, emit) {
      emit(ShowMyContacts());
    });

    on<SearchContactsEvent>((event, emit) {
      emit(SearchContacts());
    });

    on<AddContactsEvent>((event, emit) {
      emit(SearchContacts());
    });
  }
}
