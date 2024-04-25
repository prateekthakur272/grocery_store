import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../repository/category_repository.dart';
import '../repository/products_repository.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Category> popularCategories;
  final List<Product> popularProducts;
  final List<Product> featuredProducts;
  final Product? productOfTheDay;

  const HomeState({
    this.status = HomeStatus.initial,
    this.popularCategories = const [],
    this.popularProducts = const [],
    this.featuredProducts = const [],
    this.productOfTheDay,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Category>? popularCategories,
    List<Product>? popularProducts,
    List<Product>? featuredProducts,
    Product? productOfTheDay,
  }) {
    return HomeState(
      status: status ?? this.status,
      popularCategories: popularCategories ?? this.popularCategories,
      popularProducts: popularProducts ?? this.popularProducts,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      productOfTheDay: productOfTheDay ?? this.productOfTheDay,
    );
  }

  @override
  List<Object?> get props => [
    status,
    popularCategories,
    popularProducts,
    featuredProducts,
    productOfTheDay,
  ];
}

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadEvent extends HomeEvent {
  const HomeLoadEvent();
}


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryRepository _categoryRepository;
  final ProductRepository _productRepository;

  HomeBloc({
    required CategoryRepository categoryRepository,
    required ProductRepository productRepository,
  })  : _categoryRepository = categoryRepository,
        _productRepository = productRepository,
        super(const HomeState()) {
    on<HomeLoadEvent>(_onLoadEvent);
  }

  Future<void> _onLoadEvent(
      HomeLoadEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      final categories = _categoryRepository.getCategories();
      final products = _productRepository.getProducts();

      final results = await Future.wait([categories, products]);

      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          popularCategories: results[0] as List<Category>,
          popularProducts: results[1] as List<Product>,
          featuredProducts: results[1] as List<Product>,
          productOfTheDay: results[1].first as Product,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
