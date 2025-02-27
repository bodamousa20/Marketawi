import 'package:flutter/material.dart';
import 'package:marketawi/cart/cart_details.dart';
import 'package:provider/provider.dart';

import '../provider/Product_provider.dart';

class Cart extends StatefulWidget {
   Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
      final provider = Provider.of<ProductProvider>(context, listen: false);

      if (provider.userId != null) {
        provider.getUserCart(provider.userId!);
      } else {
        debugPrint("Error: userId is null. Cannot fetch cart data.");
      }

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.cartData == null
          ? const Center(child: Text("Your cart is empty"))
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.cartData!.cartItemList.length,
                itemBuilder: (context, index) {
                  final cartItem = provider.cartData!.cartItemList[index];
                  final product = cartItem.product;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.productImage!.downloadUrl,
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 80),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.brand,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async{

                                    await provider.deleteFromCart(provider.userId!,provider.cartData!.cartItemList[index].id);
                                    await provider.getUserCart(provider.userId!);

                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 26,
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() async{
                                        await provider.decrease(provider.userId!,provider.cartData!.cartItemList[index].id);
                                        await provider.getUserCart(provider.userId!);
                                      });
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      cartItem.quantity?.toString() ?? "1",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async{
                                      setState(() async{
                                        await provider.increase(provider.userId!,provider.cartData!.cartItemList[index].id);
                                        await provider.getUserCart(provider.userId!);
                                      });
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                cart_details(
                    price: "\$ ${provider.cartData?.totalPrice}",
                    text: "Sub-total"),
                cart_details(price: "\$ 0.00", text: "VAT (%)"),
                cart_details(price: "\$ 80", text: "Shipping fee"),
                const Divider(thickness: 1),
                cart_details(price: "\$ ${provider.cartData?.totalPrice}", text: "Total"),
              ],
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                debugPrint("Go to Checkout clicked");
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(54, 105, 201, 1),
                ),
                child: const Center(
                  child: Text(
                    "Go To Checkout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
