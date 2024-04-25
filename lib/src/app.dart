import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store/src/repository/category_repository.dart';
import 'package:grocery_store/src/screens/home_screen.dart';
import 'package:grocery_store/src/screens/intro_screen.dart';
import 'package:grocery_store/src/services/api_services.dart';
import 'package:grocery_store/src/shared/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context)=> CategoryRepository(apiClient: ApiService()))
      ],
      child: MaterialApp(
        title: "Grocery Store",
        home: const HomeScreen(),
        theme: themeLight,
      ),
    );
  }
}
