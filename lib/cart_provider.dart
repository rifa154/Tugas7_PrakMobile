
import 'package:flutter/material.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  // Menambahkan produk
  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(
        product: product,
        quantity: 1,
      );
    }

    notifyListeners();
  }

  // Mengurangi jumlah produk
  // Jika jumlah menjadi 0, produk otomatis dihapus
  void decreaseQuantity(int productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  // Menghitung total jumlah barang
  int get totalItems {
    int total = 0;

    for (var item in _items.values) {
      total += item.quantity;
    }

    return total;
  }

  // Menghitung total harga
  int get totalPrice {
    int total = 0;

    for (var item in _items.values) {
      total += item.product.price * item.quantity;
    }

    return total;
  }
}