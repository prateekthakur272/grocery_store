import 'package:flutter/material.dart';
import 'package:grocery_store/src/extensions/build_context_extension.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int index;
  const HomeBottomNavBar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32))
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: context.colorScheme.primary.withOpacity(0.7),
          labelTextStyle: MaterialStatePropertyAll<TextStyle>(context.textTheme.bodySmall!.copyWith(color: context.colorScheme.surface)),
          iconTheme: MaterialStatePropertyAll<IconThemeData>(IconThemeData(
            color:context.colorScheme.surface
          ))
        ),
        child: NavigationBar(
          indicatorColor: Colors.transparent,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined),
                selectedIcon: Icon(Icons.shopping_bag),
                label: "Explore"),
            NavigationDestination(
                icon: Icon(Icons.history_outlined),
                selectedIcon: Icon(Icons.history),
                label: "Orders"),
            NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: "Profile"),
          ],
        ),
      ),
    );
  }
}
