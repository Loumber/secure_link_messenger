import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/bloc/contacts_bloc.dart';
import 'package:secure_link_messenger/src/features/navigation_bar/data/providers/page_provider.dart';
import 'package:secure_link_messenger/src/features/navigation_bar/data/repositories/navigation_%20bar_items_repository_impl.dart';

Color? navigationBarBackgroundColor = Colors.red[900];

class MyNavigationBar extends ConsumerStatefulWidget {
  const MyNavigationBar({super.key});

  @override
  ConsumerState<MyNavigationBar> createState() => __MyNavigationBarState();
}

class __MyNavigationBarState extends ConsumerState<MyNavigationBar> {
  int selectedItem = 1;

  List<StateMachineController> controllers = [];

  List<SMIBool> navigationBarItem = [];

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: 60.h,
      padding: EdgeInsets.fromLTRB(35.w, 6.h, 35.w, 6.h),
      decoration: BoxDecoration(
        color: navigationBarBackgroundColor,
        borderRadius: Platform.isIOS
            ? const BorderRadius.all(Radius.circular(24))
            : const BorderRadius.all(Radius.circular(0)),
        boxShadow: [
          BoxShadow(
              color: navigationBarBackgroundColor!.withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            NavigationBarItemsRepositoryImpl().getNavigationBarItem().length,
            (index) {
          final currentNavigationBarItem = NavigationBarItemsRepositoryImpl()
              .getNavigationBarItem()[index]
              .rive;
          return GestureDetector(
            onTap: () {
              navigationBarItem[index].change(true);
              Future.delayed(const Duration(seconds: 1), () {
                navigationBarItem[index].change(false);
              });
              if (index != selectedItem) {
                ref.watch(pageProvider.notifier).update((state) => index);
              }
              if (index == 0) {
                BlocProvider.of<ContactsBloc>(context).add(MyContactsEvent());
              }
              setState(() {
                selectedItem = index;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyAnimatedContainer(isActive: index == selectedItem),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Opacity(
                    opacity: selectedItem == index ? 1 : 0.5,
                    child: RiveAnimation.asset(
                      currentNavigationBarItem.src,
                      artboard: currentNavigationBarItem.artboard,
                      onInit: (artboard) {
                        StateMachineController? controller =
                            StateMachineController.fromArtboard(artboard,
                                currentNavigationBarItem.stateMachineName);
                        artboard.addController(controller!);
                        navigationBarItem.add(
                            controller.findInput<bool>('active') as SMIBool);
                        controllers.add(controller);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    ));
  }
}

class MyAnimatedContainer extends StatelessWidget {
  const MyAnimatedContainer({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(bottom: 5.h),
      height: 4.h,
      width: isActive ? 20.w : 0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    );
  }
}
