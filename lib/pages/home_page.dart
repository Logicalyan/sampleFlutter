import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_c/pages/cart_page.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import 'add_item_page.dart';
import 'data_page.dart';
import 'history_page.dart';  // Import halaman History

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedCategory; // Kategori yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DataPage()),
              );
            },
            tooltip: 'Manage Items',
          ),
          IconButton(
            icon: const Icon(Icons.history),  // Tombol untuk melihat riwayat transaksi
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),  // Navigasi ke halaman History
              );
            },
            tooltip: 'Transaction History',
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),  // Tombol untuk melihat riwayat transaksi
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),  // Navigasi ke halaman History
              );
            },
            tooltip: 'Transaction History',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Kategori dengan Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = null; // Semua data
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedCategory == null
                        ? Colors.blue
                        : Colors.grey.shade300,
                    foregroundColor:
                        _selectedCategory == null ? Colors.white : Colors.black,
                  ),
                  child: const Text('All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'Food'; // Filter Food
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedCategory == 'Food'
                        ? Colors.blue
                        : Colors.grey.shade300,
                    foregroundColor: _selectedCategory == 'Food'
                        ? Colors.white
                        : Colors.black,
                  ),
                  child: const Text('Food'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'Drink'; // Filter Drink
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedCategory == 'Drink'
                        ? Colors.blue
                        : Colors.grey.shade300,
                    foregroundColor: _selectedCategory == 'Drink'
                        ? Colors.white
                        : Colors.black,
                  ),
                  child: const Text('Drink'),
                ),
              ],
            ),
          ),
          Expanded(
            // Daftar Item
            child: Consumer<ItemProvider>(
              builder: (context, provider, child) {
                final items = _selectedCategory == null
                    ? provider.items
                    : provider.items
                        .where((item) => item.category == _selectedCategory)
                        .toList();

                if (items.isEmpty) {
                  return const Center(
                    child: Text('No items available'),
                  );
                }

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.file(
                        File(item.image),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      subtitle:
                          Text('Price: \$${item.price.toStringAsFixed(2)}'),
                          trailing: ElevatedButton(onPressed: (){
                            provider.addItemToCart(item);
                          }, child: Text('add')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPage(
                onAddItem: (item) {
                  Provider.of<ItemProvider>(context, listen: false)
                      .addItem(item);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
