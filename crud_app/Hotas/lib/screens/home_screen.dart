import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';
import '../utils/urls.dart';
import '../widgets/product_item.dart';
import 'add_new_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> _productList = [];
  bool _getProductInprogress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductList();
  }

  Future<void> _getProductList() async {
    _productList.clear();
    _getProductInprogress = true;
    setState(() {

    });
    Uri uri = Uri.parse(Urls.getProductsUrl);
    Response response = await get(uri);

    // debugPrint(response.statusCode.toString());
    // debugPrint(response.body);

    if (response.statusCode == 200) {
      final decodeJson = jsonDecode(response.body);
      for (Map<String, dynamic> productJson in decodeJson['data']) {
        ProductModel productModel = ProductModel.fromJson(productJson);

        _productList.add(productModel);
      }
    }

    _getProductInprogress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            onPressed: () {
              _getProductList();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        title: Text("Product list"),
      ),
      body: Visibility(
        visible: _getProductInprogress == false,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: _productList.length,
          itemBuilder: (context, index) {
            return ProductItem(product: _productList[index], refreshProductList: (){
              _getProductList();
            },);
          },
          separatorBuilder: (context, index) {
            return Divider(indent: 70);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewProduct()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
