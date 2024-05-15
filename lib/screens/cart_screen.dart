import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/provider/product_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void removeFormCart(BuildContext context,ProductModel productModel){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: const Text("Are you sure want to remove !!"),
      actions: [
        MaterialButton(onPressed: ()=>Navigator.pop(context),child: const Text("Cancle"),),
        MaterialButton(onPressed: (){
          Navigator.pop(context);
          context.read<ProductProvider>().removeItem(productModel);
        },child: const Text("Remove"),),
      ],
    ),);
  }
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<ProductProvider>().cart;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cart",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
      ),
      body:cart.isEmpty ? const Center(child: Text("Cart is empty...")):
      Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
            return ListTile(
              title: Text("${item.name}"),
              subtitle: Text("\$${item.price}"),
              trailing: IconButton(onPressed: (){
                removeFormCart(context, item);
              }, icon: Icon(Icons.delete,color: Colors.red,)),
            );
            },),
          ),
        ],
      ),
    );
  }
}
