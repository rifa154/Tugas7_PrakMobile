
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product.dart';
import 'cart_provider.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const Color primaryBlue = Color(0xFF164E63);
  static const Color buttonBlue = Color(0xFF287A9B);
  static const Color backgroundBlue = Color(0xFFEAF3F7);

  // DATA PRODUK
  final List<Product> products = [
    Product(
      id: 1,
      name: 'Beras 5 Kg',
      price: 75000,
      imageUrl:
          'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
    ),
    Product(
      id: 2,
      name: 'Minyak Goreng 1 L',
      price: 18000,
      imageUrl:
          'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400',
    ),
    Product(
      id: 3,
      name: 'Gula Pasir 1 Kg',
      price: 17000,
      imageUrl:
          'https://myunipac.com/cdn/shop/files/Fine_Granulated_White_Sugar-4.png?v=1769156860&width=1445',
    ),
    Product(
      id: 4,
      name: 'Telur 1 Kg',
      price: 28000,
      imageUrl:
          'https://images.unsplash.com/photo-1518569656558-1f25e69d93d7?w=400',
    ),
    Product(
      id: 5,
      name: 'Tepung Terigu 1 Kg',
      price: 12000,
      imageUrl:
          'https://images.unsplash.com/photo-1627485937980-221c88ac04f9?w=400',
    ),
    Product(
      id: 6,
      name: 'Mie Instan',
      price: 3500,
      imageUrl:
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400',
    ),
  ];

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
          'Toko Sembako',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        // IKON KERANJANG
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 27,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CartPage(),
                          ),
                        );
                      },
                    ),

                    if (cart.totalItems > 0)
                      Positioned(
                        right: 2,
                        top: 2,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.orange,
                          child: Text(
                            '${cart.totalItems}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      // HALAMAN BERANDA
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20, 12, 20, 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SELAMAT DATANG
              const Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF263943),
                ),
              ),

              const SizedBox(height: 2),

              // DESKRIPSI
              const Text(
                'Temukan kebutuhan sehari-hari Anda.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF71838C),
                ),
              ),

              const SizedBox(height: 12),

              // JUDUL PRODUK
              const Text(
                'Produk Sembako',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: primaryBlue,
                ),
              ),

              const SizedBox(height: 10),

              // DAFTAR PRODUK
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return Card(
                      color: Colors.white,
                      elevation: 1,
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Row(
                          children: [
                            // FOTO PRODUK
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8),
                              child: Image.network(
                                product.imageUrl,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stack) {
                                  return Container(
                                    width: 64,
                                    height: 64,
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

                            // INFORMASI PRODUK
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF263943),
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    rupiah(product.price),
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

                            // TOMBOL TAMBAH
                            ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<CartProvider>()
                                    .addToCart(product);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product.name} ditambahkan ke keranjang',
                                    ),
                                    duration:
                                        const Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 16,
                              ),
                              label: const Text('Tambah'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonBlue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 11,
                                  vertical: 10,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}