import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketawi/widgets/product_item.dart';
import 'package:provider/provider.dart';

import 'DetailsPage.dart';
import '../provider/Product_provider.dart';

class searchPageResult extends StatefulWidget {
  String searchQuery;
  searchPageResult({super.key, required this.searchQuery});

  @override
  State<searchPageResult> createState() => _searchPageResultState();
}

class _searchPageResultState extends State<searchPageResult> {
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context as BuildContext, listen: false)
        .fetchProductByName(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Search Results"),elevation: 0,backgroundColor: Colors.white,foregroundColor: Colors.black),
      body: providers.loading
          ? const Center(child: CircularProgressIndicator())
          : providers.products.isEmpty
              ? Center(
                  child: Text("No products for that "),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: providers.products.length,
                  itemBuilder: (context, index) {
                    final product = providers.products[index];

                    return InkWell(
                      onTap: () {
                        int id = product.id;
                        providers.product = null;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(id: id),
                          ),
                        );
                      },
                      child: prodcut_item(
                        name: product.name,
                        price: product.price.toString(),
                        image: product.productImage.downloadUrl.toString(),
                      ),
                    );
                  },
                ),
    );
  }
}
