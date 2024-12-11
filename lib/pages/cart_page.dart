import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, provider, child) {
          if (provider.cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }

          double totalPrice = 0;

          // Menghitung total harga berdasarkan kuantitas dan harga item
          for (var item in provider.cartItems) {
            totalPrice += item.price * item.quantity;
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = provider.cartItems[index];

                    return ListTile(
                      leading: Image.file(
                        File(item.image),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      subtitle: Text(
                          'Price: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              provider.decreaseQuantity(index);
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              provider.increaseQuantity(index);
                            },
                          ),
                          // Tombol hapus item
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              provider.removeItemFromCart(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              // Tombol Checkout
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Panggil fungsi checkout
                    provider.checkout(totalPrice);
                    // Menampilkan dialog konfirmasi checkout berhasil
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Checkout Successful'),
                          content: const Text('Your order has been placed!'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Kembali ke halaman utama setelah checkout
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
