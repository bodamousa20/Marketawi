import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:marketawi/provider/Product_provider.dart';
import 'package:marketawi/widgets/product_item.dart';
import 'package:marketawi/pojo/product_pojo.dart';
import 'package:marketawi/main/searchPageResult.dart';
import 'package:provider/provider.dart';

import 'DetailsPage.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    Provider.of<ProductProvider>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<ProductProvider>(context); // Keep listen true

    return providers.loading
        ? const Center(child: CircularProgressIndicator())
        :  SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5))),
                            child: SearchBar(
                              controller: _searchController,
                              leading: Container(
                                  width: 24,
                                  height: 24,
                                  child: const Icon(Icons.search_rounded)),
                              hintText: "Search for Anything ...",
                              elevation: MaterialStateProperty.all(2),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                                color: Color.fromRGBO(54, 105, 201, 1)),
                            child: InkWell(
                              onTap: () {
                                String searchBar = _searchController.text;
                                //providers.fetchProductByName(searchBar);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => searchPageResult(
                                            searchQuery: searchBar)));
                              },
                              child: const Icon(
                                Icons.tune,
                                color: Colors.white, // Icon color
                                size: 24, // Icon size
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 35,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: providers.categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    color: Colors.white,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      String categoryName =
                                          providers.categories[index].name;
                                      if (categoryName == 'All') {
                                        providers.products.clear();
                                        providers.fetchProducts();
                                      } else {
                                        providers.fetchProductsByCategoryName(
                                            categoryName);
                                      }
                                    },
                                    child: Text(
                                      providers.categories[index].name,
                                      style: const TextStyle(
                                          color: Color.fromRGBO(26, 26, 26, 1),
                                          fontSize: 16),
                                    ),
                                  )),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: providers.products.length,
                          itemBuilder: (context, index) {
                            final product = providers.products[index];

                            return InkWell(
                              onTap: () {
                                print("image url " +
                                    product.productImage.downloadUrl);
                                int id = product.id;
                                providers.product = null;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsPage(id: id)));
                                DetailsPage(
                                  id: id,
                                );
                              },
                              child: prodcut_item(
                                name: product.name,
                                price: product.price.toString(),
                                image:
                                    product.productImage.downloadUrl.toString(),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
  }
}
