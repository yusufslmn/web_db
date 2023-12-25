import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_db/core/Utility/screen_size.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class Order {
  final String orderId;
  final DateTime orderDate;
  final double price;
  final String payment;

  Order(
      {required this.payment,
      required this.orderId,
      required this.orderDate,
      required this.price});
}

class _MyOrdersState extends State<MyOrders> {
  PageController controller = PageController();

  final List<Order> orders = [
    Order(
        orderId: '550 403 032',
        orderDate: DateTime.timestamp(),
        price: 50.0,
        payment: "Kredi Kartı"),
    Order(
        orderId: '550 423 423',
        orderDate: DateTime.timestamp(),
        price: 15.0,
        payment: "Kredi Kartı"),
    Order(
        orderId: '344 564 524',
        orderDate: DateTime.timestamp(),
        price: 25.0,
        payment: "Kredi Kartı"),
  ];
  List<ExpansionTileController> controllerEx = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(0.5),
      height: context.height(1),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              collapsedShape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              subtitle: Text(DateFormat('yyyy-MM-dd hh:mm:ss')
                  .format(orders[index].orderDate)),
              title: Row(
                children: [
                  Text(
                    "Sipariş no: ",
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w100),
                  ),
                  Text(
                    orders[index].orderId,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${orders[index].price} TL",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            orders[index].payment,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                Container(
                  height: context.height(0.3),
                  width: context.width(0.5),
                  color: Colors.orange,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
