import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/provider/product_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyCartListTile extends StatelessWidget {
 final ProductModel productModel;
 final void Function()? onTapIncrement;
 final void Function()? onTapDecrement;
  const MyCartListTile({super.key,required this.productModel,required this.onTapDecrement,required this.onTapIncrement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Image.network(productModel.image.toString())),
                )),
            const SizedBox(width: 6,),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex :3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("${productModel.name}",style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                             Text("\$${productModel.price}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                           ],
                         ),
                          Row(
                            children: [
                              InkWell(
                                onTap:onTapDecrement,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Theme.of(context).colorScheme.background,
                                  child: Icon(Icons.remove,color:Theme.of(context).colorScheme.inversePrimary ,),
                                ),
                              ),
                              const SizedBox(width: 6,),
                              Consumer<ProductProvider>(builder: (context, value, child) {
                               return Text("${value.count}");
                              },),
                              const SizedBox(width: 6,),
                              InkWell(
                                onTap: onTapIncrement,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Theme.of(context).colorScheme.background,
                                  child: Icon(Icons.add,color:Theme.of(context).colorScheme.inversePrimary ,),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: IconButton(onPressed: (){
                        context.read<ProductProvider>().removeItem(productModel);
                      }, icon: const Icon(Icons.delete,color: Colors.red,)),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
