import 'package:flutter/material.dart';
import 'package:marketawi/cart_details.dart';

class cart extends StatelessWidget {
  const cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Cart",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 66,
                itemBuilder: (context, index) {
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
                              "https://s3-alpha-sig.figma.com/img/6b3f/8893/ab73c02711e3ab3f75782fe9115b28b5?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pcXDjCLjUxABE5lHG57lsf1al3LbynmZgZNSLxoY2RXXPF3uiuSTTY2Ms0GxGkUvDwXU15kjKP~qV0Wp6rpYSarj8zuQoikVSJLG5GFlZVs0v79PiGUKZsVfia2tg~vYa~Dgs6b6E6~Zb70NLeSK~zoRBxTMP9EYyHT9XFq1uuTe00UDTSgH4nRaE8kcSQtTGaMuywYyJLK9WIO-YBqwPudyQgLXlizwazzZixTVIYUPnzFgaqybzgz-KKKGQ8YOHGUqcnamRNJ21P0gCrgSt6dP54CfgrMPvBfWIrTTOYUIRv-j6FM40ouTDowGeiiwdj1h-rd1SvoH8zmeJNPztg__",
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Regular Fit T-Shirt",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Size M",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "\$ 20",
                                  style: TextStyle(
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
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 26,
                                ),
                              ),
                              Row(
                                children: [
                                  _quantityButton(Icons.remove, () {}),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  _quantityButton(Icons.add, () {}),
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
                cart_details(price: "\$ 5,870", text: "Sub-total"),
                cart_details(price: "\$ 0.00", text: "VAT (%)"),
                cart_details(price: "\$ 80", text: "Shipping fee"),
                const Divider(thickness: 1),
                cart_details(price: "\$ 5,950", text: "Total"),
              ],
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                print("Go to Checkout clicked");
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

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
