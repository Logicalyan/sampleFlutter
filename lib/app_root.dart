import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';
import '../providers/item_provider.dart';

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemProvider(),  // Menyediakan provider untuk aplikasi
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Item Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),  
        // Widget ini akan menjadi halaman utama
      ),
    );
  }
}
