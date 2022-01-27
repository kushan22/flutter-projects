import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;

  Future _getOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture = _getOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text("An Error Occurred!!"),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(
                    order: ordersData.orders[i],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
