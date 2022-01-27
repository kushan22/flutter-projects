import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final ordersData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '${cartData.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  orderButton(cartData: cartData, ordersData: ordersData)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.getItemCount,
              itemBuilder: (ctx, i) => CartItem(
                id: cartData.items.values.toList()[i].id,
                productId: cartData.items.keys.toList()[i],
                price: cartData.items.values.toList()[i].price,
                quantity: cartData.items.values.toList()[i].quantity,
                title: cartData.items.values.toList()[i].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    Key key,
    @required this.cartData,
    @required this.ordersData,
  }) : super(key: key);

  final Cart cartData;
  final Orders ordersData;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: (widget.cartData.totalAmount <= 0 || _isLoading)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await widget.ordersData.addOrder(
                  widget.cartData.items.values.toList(),
                  widget.cartData.totalAmount,
                );

                setState(() {
                  _isLoading = false;
                });
                widget.cartData.clearCart();
              },
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(
                "ORDER NOW",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ));
  }
}
