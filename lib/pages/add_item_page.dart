// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:async';

// class Item {
//   String name;
//   double price;
//   String imageUrl;
//   String category;

//   Item({
//     required this.name,
//     required this.price,
//     required this.imageUrl,
//     required this.category,
//   });
// }

// class AddItemPage extends StatefulWidget {
//   final Function(Item) onAddItem;

//   AddItemPage({required this.onAddItem});

//   @override
//   _AddItemPageState createState() => _AddItemPageState();
// }

// class _AddItemPageState extends State<AddItemPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   String? _selectedCategory;
//   File? _selectedImage;


//   Future<void> _pickImage() async {
//   final ImagePicker _picker = ImagePicker();
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Item')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                   validator: (value) => value!.isEmpty ? 'Enter a name' : null,
//                 ),
//                 TextFormField(
//                   controller: _priceController,
//                   decoration: InputDecoration(labelText: 'Price'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) => value!.isEmpty ? 'Enter a price' : null,
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _selectedCategory,
//                   hint: Text('Select Category'),
//                   items: ['Food', 'Drink', 'Others']
//                       .map((category) => DropdownMenuItem(
//                             value: category,
//                             child: Text(category),
//                           ))
//                       .toList(),
//                   onChanged: (value) => setState(() {
//                     _selectedCategory = value;
//                   }),
//                   validator: (value) =>
//                       value == null ? 'Please select a category' : null,
//                 ),
//                 SizedBox(height: 10),
//                 _selectedImage == null
//                     ? Text('No image selected')
//                     : Image.file(
//                         _selectedImage!,
//                         height: 150,
//                       ),
//                 TextButton.icon(
//                   onPressed: _pickImage,
//                   icon: Icon(Icons.image),
//                   label: Text('Select Image'),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate() &&
//                         _selectedImage != null) {
//                       widget.onAddItem(
//                         Item(
//                           name: _nameController.text,
//                           price: double.parse(_priceController.text),
//                           imageUrl: _selectedImage!.path,
//                           category: _selectedCategory!,
//                         ),
//                       );
//                       Navigator.pop(context);
//                     } else if (_selectedImage == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Please select an image')),
//                       );
//                     }
//                   },
//                   child: Text('Add Item'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';

class FormPage extends StatefulWidget {
  final Function(Item) onAddItem;

  FormPage({super.key, required this.onAddItem});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Item')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: Text('Select Category'),
              items: ['Food', 'Drink']
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) => setState(() {
                _selectedCategory = value;
              }),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty &&
                    _selectedCategory != null) {
                  widget.onAddItem(Item(
                    name: _nameController.text,
                    price: double.parse(_priceController.text),
                    image: 'imagePath',  // Replace with actual image path
                    category: _selectedCategory!,
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
