import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../repository/category_repository.dart';
import '../repository/products_repository.dart';

enum CategoryStatus { initial, loading, loaded, error }

class CategoryState extends Equatable {
  final CategoryStatus status;
  final Category? category;
  final List<Product> categoryProducts;

  const CategoryState({
    this.status = CategoryStatus.initial,
    this.category,
    this.categoryProducts = const [],
  });

  CategoryState copyWith({
    CategoryStatus? status,
    Category? category,
    List<Product>? categoryProducts,
  }) {
    return CategoryState(
      status: status ?? this.status,
      category: category ?? this.category,
      categoryProducts: categoryProducts ?? this.categoryProducts,
    );
  }

  @override
  List<Object?> get props => [status, category, categoryProducts];
}


abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryLoadEvent extends CategoryEvent {
  final String categoryId;

  const CategoryLoadEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  final ProductRepository _productRepository;

  CategoryBloc({
    required CategoryRepository categoryRepository,
    required ProductRepository productRepository,
  })  : _categoryRepository = categoryRepository,
        _productRepository = productRepository,
        super(const CategoryState()) {
    on<CategoryLoadEvent>(_onLoadEvent);
  }

  Future<void> _onLoadEvent(
      CategoryLoadEvent event,
      Emitter<CategoryState> emit,
      ) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      final categories = _categoryRepository.getCategoryById(event.categoryId);
      final products = _productRepository.getProductsByCategoryId(
        event.categoryId,
      );

      final results = await Future.wait([categories, products]);

      emit(
        state.copyWith(
          status: CategoryStatus.loaded,
          category: results[0] as Category,
          categoryProducts: results[1] as List<Product>,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }
}
