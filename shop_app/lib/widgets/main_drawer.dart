import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              "Hello Friend!!",
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildListTile("Shop", Icons.shopping_cart_rounded, () {
            Navigator.pushNamed(context, "/");
          }),
          Divider(),
          buildListTile("Orders", Icons.payment, () {
            Navigator.pushNamed(context, OrdersScreen.routeName);
          }),
          Divider(),
          buildListTile("Manage Products", Icons.edit, () {
            Navigator.pushNamed(context, UserProductsScreen.routeName);
          }),
        ],
      ),
    );
  }
}
