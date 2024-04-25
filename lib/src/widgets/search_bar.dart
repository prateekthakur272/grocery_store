import 'package:flutter/material.dart';
import 'package:grocery_store/src/extensions/build_context_extension.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  const HomeSearchBar({super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: context.colorScheme.primary.withOpacity(0.7),
          hintStyle: context.textTheme.bodyLarge!
              .copyWith(color: context.colorScheme.onPrimary.withOpacity(0.6)),
        prefixIcon: Icon(Icons.search, color: context.colorScheme.onPrimary,)
      ),
    );
  }
}
