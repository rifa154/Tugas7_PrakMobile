
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const Color primaryBlue = Color(0xFF164E63);
  static const Color buttonBlue = Color(0xFF287A9B);
  static const Color backgroundBlue = Color(0xFFEAF3F7);

  // FORMAT RUPIAH
  String rupiah(int harga) {
    final result = harga.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return 'Rp $result';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,

      // APP BAR
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // KERANJANG
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {

          // KERANJANG KOSONG
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 65,
                    color: buttonBlue,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Keranjang Masih Kosong',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Silakan pilih produk terlebih dahulu.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [

              // DAFTAR PRODUK
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 950,
                    ),

                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16, 16, 16, 16,
                      ),

                      itemCount: cart.items.length,

                      itemBuilder: (context, index) {
                        final item =
                            cart.items.values.toList()[index];

                        return Card(
                          color: Colors.white,
                          elevation: 1,

                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(12),

                            child: Row(
                              children: [
                                // FOTO PRODUK
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(8),

                                  child: Image.network(
                                    item.product.imageUrl,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,

                                    loadingBuilder:
                                        (context, child, progress) {
                                      if (progress == null) {
                                        return child;
                                      }

                                      return Container(
                                        width: 70,
                                        height: 70,
                                        color: backgroundBlue,
                                        child: const Center(
                                          child:
                                              CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },

                                    errorBuilder:
                                        (context, error, stack) {
                                      return Container(
                                        width: 70,
                                        height: 70,
                                        color: backgroundBlue,
                                        child: const Icon(
                                          Icons.image_outlined,
                                          color: buttonBlue,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // NAMA DAN HARGA
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        item.product.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF263943),
                                        ),
                                      ),

                                      const SizedBox(height: 5),

                                      Text(
                                        rupiah(item.product.price),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: buttonBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // KONTROL JUMLAH DI KANAN
                                Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    // KURANG
                                    IconButton(
                                      onPressed: () {
                                        cart.decreaseQuantity(
                                          item.product.id,
                                        );
                                      },

                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),

                                      color: buttonBlue,
                                      tooltip: 'Kurangi jumlah',
                                      visualDensity:
                                          VisualDensity.compact,

                                      constraints:
                                          const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 40,
                                      ),

                                      padding: EdgeInsets.zero,
                                    ),

                                    // JUMLAH
                                    SizedBox(
                                      width: 25,

                                      child: Text(
                                        '${item.quantity}',
                                        textAlign: TextAlign.center,

                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF263943),
                                        ),
                                      ),
                                    ),

                                    // TAMBAH
                                    IconButton(
                                      onPressed: () {
                                        cart.addToCart(
                                          item.product,
                                        );
                                      },

                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),

                                      color: buttonBlue,
                                      tooltip: 'Tambah jumlah',
                                      visualDensity:
                                          VisualDensity.compact,

                                      constraints:
                                          const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 40,
                                      ),

                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // RINGKASAN BELANJA
              Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFDCE6EA),
                      width: 1,
                    ),
                  ),
                ),

                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 560,
                    ),

                    child: SafeArea(
                      top: false,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'Ringkasan Belanja',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // JUMLAH BARANG
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                            children: [
                              const Text(
                                'Jumlah Barang',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),

                              Text(
                                '${cart.totalItems} barang',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF263943),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 9),

                          // TOTAL BELANJA
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                            children: [
                              const Text(
                                'Total Belanja',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF263943),
                                ),
                              ),

                              Flexible(
                                child: Text(
                                  rupiah(cart.totalPrice),
                                  textAlign: TextAlign.end,

                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: buttonBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 13),

                          // CHECKOUT
                          SizedBox(
                            width: double.infinity,
                            height: 44,

                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Fitur checkout belum tersedia.',
                                    ),
                                  ),
                                );
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                foregroundColor: Colors.white,
                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                              ),

                              child: const Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}