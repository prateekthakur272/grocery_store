import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../repository/cart_repository.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState extends Equatable {
  final CartStatus status;
  final Cart? cart;

  const CartState({
    this.status = CartStatus.initial,
    this.cart,
  });

  CartState copyWith({
    CartStatus? status,
    Cart? cart,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [status, cart];
}


abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  final String userId;

  const LoadCart(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddToCart extends CartEvent {
  final String userId;
  final Product product;

  const AddToCart({
    required this.userId,
    required this.product,
  });

  @override
  List<Object> get props => [product, userId];
}

class RemoveFromCart extends CartEvent {
  final String userId;
  final CartItem cartItem;

  const RemoveFromCart({
    required this.userId,
    required this.cartItem,
  });

  @override
  List<Object> get props => [cartItem, userId];
}

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc({
    required CartRepository cartRepository,
  })  : _cartRepository = cartRepository,
        super(const CartState()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      final cart = await _cartRepository.getCart(event.userId);

      emit(
        state.copyWith(
          status: CartStatus.loaded,
          cart: cart,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  Future<void> _onAddToCart(
      AddToCart event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      await _cartRepository.addToCart(event.userId, event.product);
      emit(state.copyWith(status: CartStatus.loaded));
      add(LoadCart(event.userId));
    } catch (_) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      await _cartRepository.removeFromCart(
        event.userId,
        event.cartItem.id,
      );

      emit(state.copyWith(status: CartStatus.loaded));
      add(LoadCart(event.userId));
    } catch (_) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }
}
