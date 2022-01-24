import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem({this.id, this.productId, this.price, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        // This returns the future that is basically a navigator pop value it then calls onDismissed based on the value
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Are you sure",
            ),
            content: Text(
              "Do you want to remove the item from the cart?",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Yes"),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        cartData.removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$${price}'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text(
              "Total: \$${price * quantity}",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    cartData.addItem(productId, price, title);
                  },
                  iconSize: 15,
                  color: Theme.of(context).errorColor,
                ),
                Text(
                  '$quantity x',
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    cartData.removeQuantity(productId);
                  },
                  iconSize: 15,
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
