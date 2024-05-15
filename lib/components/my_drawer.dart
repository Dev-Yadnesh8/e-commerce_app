import 'package:e_commerce_app/components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // header with logo
          DrawerHeader(
              child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.shopping_bag,size: 80,color: Theme.of(context).colorScheme.inversePrimary,),
                      const Text("Menu",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                    ],
                  ))),
          const SizedBox(height: 20,),
          // list
          MyListTile(icon: Icons.home, title: "Home", onTap: ()=>Navigator.pop(context)),
          MyListTile(
              icon: Icons.shopping_cart,
              title: "Cart",
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,'/cartScreen');
              }),
        ],
      ),
    );
  }
}
