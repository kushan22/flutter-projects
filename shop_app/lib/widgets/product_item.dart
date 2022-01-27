import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // );

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cartData = Provider.of<Cart>(context, listen: false);

    final scaffold = ScaffoldMessenger.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () async {
              try {
                await product.toggleFavoriteStatus();
              } catch (error) {
                scaffold.showSnackBar(
                    SnackBar(content: Text("Could not update Favorites!!")));
              }
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cartData.addItem(
                product.id,
                product.price,
                product.title,
              );
              ScaffoldMessenger.of(context)
                  .hideCurrentSnackBar(); // To hide the previous snackbar before showing the next
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Added to the Cart!",
                  ),
                  duration: Duration(
                    seconds: 2,
                  ),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cartData.removeQuantity(product.id);
                      }),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
