import 'package:crud_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/product/product_bloc.dart';
import '../../blocs/product/product_event.dart';

class AddProductPage extends StatefulWidget {

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField('ID', _idController, TextInputType.number),
                _buildTextField('Category ID', _categoryIdController, TextInputType.number),
                _buildTextField('Category Name', _categoryNameController, TextInputType.text),
                _buildTextField('SKU', _skuController, TextInputType.text),
                _buildTextField('Name', _nameController, TextInputType.text),
                _buildTextField('Description', _descriptionController, TextInputType.text),
                _buildTextField('Weight', _weightController, TextInputType.number),
                _buildTextField('Width', _widthController, TextInputType.number),
                _buildTextField('Length', _lengthController, TextInputType.number),
                _buildTextField('Height', _heightController, TextInputType.number),
                _buildTextField('Image URL', _imageController, TextInputType.url),
                _buildTextField('Price (Harga)', _hargaController, TextInputType.number),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final Map<String, dynamic> productData = {
                            "id": int.tryParse(_idController.text) ?? 0,
                            "categoryId": int.tryParse(_categoryIdController.text) ?? 0,
                            "categoryName": _categoryNameController.text,
                            "sku": _skuController.text,
                            "name": _nameController.text,
                            "description": _descriptionController.text,
                            "weight": int.tryParse(_weightController.text) ?? 0,
                            "width": int.tryParse(_widthController.text) ?? 0,
                            "length": int.tryParse(_lengthController.text) ?? 0,
                            "height": int.tryParse(_heightController.text) ?? 0,
                            "image": _imageController.text,
                            "harga": int.tryParse(_hargaController.text) ?? 0,
                          };

                          context.read<ProductBloc>().add(AddProduct(productData));

                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Add Product'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
