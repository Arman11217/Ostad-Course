import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';
import '../utils/urls.dart';
import '../widgets/snackbar_massage.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.product});

  final ProductModel product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  bool __updateProductInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageUrlTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.name;
    _codeTEController.text = widget.product.code.toString();
    _quantityTEController.text = widget.product.quantity.toString();
    _priceTEController.text = widget.product.unitPrice.toString();
    _imageUrlTEController.text = widget.product.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                TextField(
                  controller: _nameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Product name",
                      labelText: "Product name"
                  ),
                ),
                TextField(
                  controller: _codeTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Product code",
                      labelText: "Product code"
                  ),
                ),
                TextField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Quantity",
                      labelText: "Quantity"
                  ),
                ),
                TextField(
                  controller: _priceTEController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "unit price",
                      labelText: "Unit price"
                  ),
                ),
                TextField(
                  controller: _imageUrlTEController,
                  decoration: InputDecoration(
                      hintText: "Image url",
                      labelText: "Image url"
                  ),
                ),
                const SizedBox(height: 8,),
                Visibility(
                  visible: __updateProductInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: FilledButton(
                      onPressed: _updateProduct,
                      child: Text("Update Product")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async{
    if(_formKey.currentState!.validate() == false){
      return;
    }

    __updateProductInProgress = true;
    setState(() {});

    Uri uri = Uri.parse(Urls.updateProductUrl(widget.product.id));
    print(uri);

    int totalPrice =
        int.parse(_priceTEController.text) *
            int.parse(_quantityTEController.text);

    Map<String, dynamic> requestBody = {
      "ProductName": _nameTEController.text,
      "ProductCode": int.parse(_priceTEController.text),
      "Img": _imageUrlTEController.text,
      "Qty": int.parse(_quantityTEController.text),
      "UnitPrice": int.parse(_priceTEController.text),
      "TotalPrice": totalPrice,
    };

    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      if (decodedJson['status'] == "success") {
        _clearTextFields();
        showSnackBarMessage(context, "Updated created successfully");
      } else {
        String errorMessage = decodedJson["data"];
        showSnackBarMessage(context, errorMessage);
      }
    }
    __updateProductInProgress = false;
    setState(() {});
  }

  void _clearTextFields() {
    _nameTEController.clear();
    _codeTEController.clear();
    _priceTEController.clear();
    _quantityTEController.clear();
    _imageUrlTEController.clear();
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _imageUrlTEController.dispose();
    _priceTEController.dispose();
    _quantityTEController.dispose();
    _codeTEController.dispose();

    super.dispose();
  }
}