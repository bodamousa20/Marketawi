import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Product_provider.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  void initState() {
    super.initState();

    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<ProductProvider>(context); // Keep listen true

    return Scaffold(
      body: providers.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 54, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 22,
                                color: Color.fromRGBO(26, 26, 26, 1),
                              )),
                          const Expanded(
                              child: Center(
                                  child: Center(
                                      child: Text(
                            "Details",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ))))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 341,
                        height: 341,
                        child: ClipRRect(
                          // Ensures image follows border radius
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          child: Image.network(
                            providers.product!.productImage.downloadUrl,
                            fit: BoxFit.cover,
                            // Makes the image fill the container properly
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        providers.product!.name,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_rate,
                            color: Color.fromRGBO(255, 169, 40, 1),
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "4.3/5.0",
                            style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)
                                .copyWith(decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(providers.product!.description,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(164, 151, 150, 150)))
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Price Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Price",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$ " + providers.product!.price.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            // Add to Cart Button
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 220,
                                height: 50, // Adjusted height
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(54, 105, 201, 1),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Add To Cart",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
