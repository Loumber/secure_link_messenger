import 'package:secure_link_messenger/src/features/navigation_bar/domain/entities/navigation_bar_item_entity.dart';

abstract class NavigationBarItemsRepository {
  List<NavigationBarItemEntity> getNavigationBarItem();
}
