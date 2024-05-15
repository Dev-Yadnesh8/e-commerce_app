import 'package:e_commerce_app/components/my_drawer.dart';
import 'package:e_commerce_app/components/my_product_tile.dart';
import 'package:e_commerce_app/provider/product_data_provider.dart';
import 'package:e_commerce_app/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 // ProductProvider productProvider = ProductProvider();

  @override
  void initState() {
    // TODO: implement initState
   // productProvider.getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    final provider = Provider.of<ProductProvider>(context,listen: false);
    provider.getProduct();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/cartScreen'),
              child: Consumer<ProductProvider>(
                builder: (context, provider, _) => Badge(
                  label: Text("${provider.cart.length}"),
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Bat Shope",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      drawer: const MyDrawer(),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return  Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.inversePrimary,));
          } else {
            return ListView(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Popular premium products",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      ProductModel productModel = provider.products[index];
                      return ProductTile(
                        productModel: productModel,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                productModel: productModel,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
