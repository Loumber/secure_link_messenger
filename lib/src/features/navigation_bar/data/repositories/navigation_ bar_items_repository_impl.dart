// ignore_for_file: file_names

import 'package:secure_link_messenger/src/features/navigation_bar/domain/entities/navigation_bar_item_entity.dart';
import 'package:secure_link_messenger/src/features/navigation_bar/domain/entities/rive_entity.dart';
import 'package:secure_link_messenger/src/features/navigation_bar/domain/repositories/navigation_bar_items_repository.dart';

class NavigationBarItemsRepositoryImpl implements NavigationBarItemsRepository {
  @override
  List<NavigationBarItemEntity> getNavigationBarItem() {
    List<NavigationBarItemEntity> navigationBarItems = [
      NavigationBarItemEntity(
          title: 'Contacts',
          rive: RiveEntity(
              src: 'assets/icons/animated_icon.riv',
              artboard: 'USER',
              stateMachineName: 'USER_Interactivity')),
      NavigationBarItemEntity(
          title: 'Chat',
          rive: RiveEntity(
              src: 'assets/icons/animated_icon.riv',
              artboard: 'CHAT',
              stateMachineName: 'CHAT_Interactivity')),
      NavigationBarItemEntity(
          title: 'Settings',
          rive: RiveEntity(
              src: 'assets/icons/animated_icon.riv',
              artboard: 'SETTINGS',
              stateMachineName: 'SETTINGS_Interactivity')),
    ];
    return navigationBarItems;
  }
}
