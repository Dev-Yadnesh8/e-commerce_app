import 'package:e_commerce_app/components/myCartListTile.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/provider/product_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
    CartScreen({super.key});

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
   late int newPrice = 0;
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
           SizedBox(
            height: 40,
            child:Text("Total:-\$$newPrice",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),) ,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
            return MyCartListTile(productModel: item,
              onTapDecrement: () {context.read<ProductProvider>().decrementCount(item);},
              onTapIncrement: () {context.read<ProductProvider>().incrementCount(item);},);
            },),
          ),
        ],
      ),
    );
  }
}
