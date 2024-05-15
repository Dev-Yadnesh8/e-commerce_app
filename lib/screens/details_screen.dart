import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/provider/product_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel productModel;

   const DetailsScreen({super.key, required this.productModel});

   void addToCart(BuildContext context){
     showDialog(context: context, builder: (context) => AlertDialog(
       content: const Text("Are you sure want to add?"),
       actions: [
         MaterialButton(onPressed: ()=>Navigator.pop(context),child: const Text("Cancle"),),
         MaterialButton(onPressed: (){
           Navigator.pop(context);
           context.read<ProductProvider>().addItem(productModel);
         },child: const Text("Add"),),
       ],
     ),);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: mClipper(),
                          child: Container(
                            height: 500,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.dstOut,
                            ),
                            child: Image.network(
                              productModel.image.toString(),
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // image of product

                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${productModel.name}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 24),
                    ),
                    Text(
                      "price: \$${productModel.price}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "About",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    Text("${productModel.about}"),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 22.0),
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                    onPressed: () {
                      addToCart(context);
                    },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)
                  ),
                    child: const Text("Add to cart",style: TextStyle(color: Colors.black),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class mClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Starting from middle of the left side
    path.moveTo(0, size.height / 2);

    // Moving to top-right corner
    path.lineTo(size.width, 0);

    // Moving to bottom-right corner
    path.lineTo(size.width, size.height);

    // Moving to bottom-left corner
    path.lineTo(0, size.height);
    // Closing the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Returning false because clipping path is fixed
    return false;
  }
}