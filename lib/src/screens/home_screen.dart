import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_store/src/extensions/build_context_extension.dart';
import 'package:grocery_store/src/widgets/bottom_nav_bar.dart';
import 'package:grocery_store/src/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary.withOpacity(0.7),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Location",
              style: context.textTheme.titleSmall,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Indore, India',
                  style: context.textTheme.titleMedium,
                ),
                const Icon(Icons.expand_more)
              ],
            )
          ],
        ),
        centerTitle: true,
        actions: [
          Badge(
            isLabelVisible: true,
              label: const Text('2'),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart)))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: const HomeSearchBar(hintText: "Search Products",),
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNavBar(index: 0,),
      floatingActionButton: FloatingActionButton(onPressed: (){},elevation: 0,child: const Icon(Icons.qr_code),),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
