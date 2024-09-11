import 'package:crud_app/blocs/product/product_state.dart';
import 'package:crud_app/services/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/product/product_bloc.dart';
import '../../blocs/product/product_event.dart';

class EditProductPage extends StatefulWidget {
  final String id;

  const EditProductPage({Key? key, required this.id}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
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
    return BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(ProductService())..add(DetailProduct(widget.id)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF6F8FB),
          title: const Text('Edit Product'),
          centerTitle: true,
        ),
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailSuccess) {
              return  Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField('ID', _idController, TextInputType.number, state.response.id.toString()),
                        _buildTextField('Category ID', _categoryIdController, TextInputType.number, state.response.categoryId.toString()),
                        _buildTextField('Category Name', _categoryNameController, TextInputType.text, state.response.categoryName!),
                        _buildTextField('SKU', _skuController, TextInputType.text, state.response.sku!),
                        _buildTextField('Name', _nameController, TextInputType.text, state.response.name!),
                        _buildTextField('Description', _descriptionController, TextInputType.text, state.response.description!),
                        _buildTextField('Weight', _weightController, TextInputType.number, state.response.weight.toString()),
                        _buildTextField('Width', _widthController, TextInputType.number, state.response.width.toString()),
                        _buildTextField('Length', _lengthController, TextInputType.number, state.response.length.toString()),
                        _buildTextField('Height', _heightController, TextInputType.number, state.response.height.toString()),
                        _buildTextField('Image URL', _imageController, TextInputType.url, state.response.image.toString()),
                        _buildTextField('Price (Harga)', _hargaController, TextInputType.number, state.response.harga.toString()),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final Map<String, dynamic> updatedProduct = {
                                    "_id": widget.id,
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
                                  context.read<ProductBloc>().add(UpdateProduct(updatedProduct));
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
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType inputType, String value) {
    controller.text = value;

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
