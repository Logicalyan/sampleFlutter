import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Items'),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, provider, child) {
          if (provider.items.isEmpty) {
            return const Center(
              child: Text('No items available'),
            );
          }

          return ListView.builder(
            itemCount: provider.items.length,
            itemBuilder: (context, index) {
              final item = provider.items[index];
              return ListTile(
                leading: Image.file(
                  File(item.image),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(item.name),
                subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.removeItem(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);  // Kembali ke halaman sebelumnya
        },
        child: const Icon(Icons.check),
        tooltip: 'Finish Managing Items',
      ),
    );
  }
}
