import 'package:crud_app/models/product.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.product});

  final ProductModel product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

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
                FilledButton(
                    onPressed: (){
                      _updateProduct();
                    },
                    child: Text("Update Product"))
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
