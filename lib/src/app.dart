import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store/src/blocs/cart_bloc.dart';
import 'package:grocery_store/src/repository/cart_repository.dart';
import 'package:grocery_store/src/repository/category_repository.dart';
import 'package:grocery_store/src/repository/products_repository.dart';
import 'package:grocery_store/src/screens/home_screen.dart';
import 'package:grocery_store/src/services/api_services.dart';
import 'package:grocery_store/src/shared/theme.dart';

import 'blocs/home_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => CategoryRepository(apiClient: ApiService())),
        RepositoryProvider(
            create: (context) => ProductRepository(apiClient: ApiService())),
        RepositoryProvider(
            create: (context) => CartRepository(apiClient: ApiService()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(
              categoryRepository: context.read<CategoryRepository>(),
              productRepository: context.read<ProductRepository>(),
            )..add(const HomeLoadEvent()),
          ),
          BlocProvider(create: (context)=> CartBloc(cartRepository: context.read<CartRepository>()))
        ],
        child: MaterialApp(
          title: "Grocery Store",
          home: const HomeScreen(),
          theme: themeLight,
        ),
      ),
    );
  }
}
