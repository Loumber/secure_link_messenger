import 'dart:io';

class SearchedUserEntity {
  final String contactName;
  final File avatar;
  final String uId;

  SearchedUserEntity(
      {required this.contactName, required this.avatar, required this.uId});
}
