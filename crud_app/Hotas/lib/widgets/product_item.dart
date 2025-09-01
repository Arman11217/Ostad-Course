
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';
import '../screens/update_product.dart';
import '../utils/urls.dart';
// import 'package:http/http.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.refreshProductList
  });

  final ProductModel product;
  final VoidCallback refreshProductList;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  bool _deleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(widget.product.image, errorBuilder: (_, __, ___){
          return Icon(Icons.error_outline);
        },),
      ),
      title: Text(widget.product.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Code: ${widget.product.code}"),
          Row(
            spacing: 14,
            children: [Text("Quantity: ${widget.product.quantity}"), Text("Unit price: ${widget.product.unitPrice}")],
          ),
        ],
      ),
      trailing: Visibility(
        visible: _deleteInProgress == false,
        replacement: CircularProgressIndicator(),
        child: PopupMenuButton<ProductOptions>(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: ProductOptions.update,
                child: Text("Update"),
              ),
              PopupMenuItem(
                value: ProductOptions.delete,
                child: Text("Delete"),
              ),
            ];
          },
          onSelected: (ProductOptions selectedOption) {
            if (selectedOption == ProductOptions.delete) {
              _deleteProduct();
            } else if (selectedOption == ProductOptions.update) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateProduct(product: widget.product,)),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _deleteProduct() async {

    _deleteInProgress = true;
    setState(() {});

    Uri uri = Uri.parse(Urls.deleteProductUrl(widget.product.id));
    Response response = await get(uri);

    // debugPrint(response.statusCode.toString());
    // debugPrint(response.body);

    if (response.statusCode == 200) {
      widget.refreshProductList();
    }

    _deleteInProgress = false;
    setState(() {});
  }
}

enum ProductOptions { update, delete }