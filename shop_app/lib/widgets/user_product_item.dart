import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(
        context); // Because we can't use context in a Future function
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName,
                  arguments: id);
            },
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              try {
                await Provider.of<ProductsProvider>(context, listen: false)
                    .deleteProduct(id);
              } catch (error) {
                scaffold
                    .showSnackBar(SnackBar(content: Text("Deleting Failed")));
              }
            },
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
