import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/models/models.dart';
import '/screens/screens.dart';
import '/controllers/controllers.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFCB8),
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Color(0xff07B300),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Card(
                margin: EdgeInsets.zero,
                color: Color(0xffB4FC20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => NewProductScreen());
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'Add a New Product',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 210,
                      child: ProductCard(
                        product: productController.products[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
            const SizedBox(height: 10),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 65,
                  width: 56,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Price',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Slider(
                            value: product.price.toDouble(),
                            min: 0,
                            max: 7000,
                            divisions: 23,
                            activeColor: Color(0xff07B300),
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                              productController.updateProductPrice(
                                index,
                                product,
                                value,
                              );
                            },
                            onChangeEnd: (value) {
                              productController.saveNewProductPrice(
                                  product, 'price', value);
                            },
                          ),
                          Text(
                            'R${product.price.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Qty.',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Slider(
                            value: product.quantity.toDouble(),
                            min: 0,
                            max: 7000,
                            divisions: 23,
                            activeColor: Color(0xff07B300),
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                              productController.updateProductQuantity(
                                index,
                                product,
                                value.toInt(),
                              );
                            },
                            onChangeEnd: (value) {
                              productController.saveNewProductQuantity(
                                product,
                                'quantity',
                                value.toInt(),
                              );
                            },
                          ),
                          Text(
                            '${product.quantity.toInt()}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
