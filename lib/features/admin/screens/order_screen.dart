import 'package:amazon_flutter_application/constants/loader.dart';
import 'package:amazon_flutter_application/features/account/widget/single_product.dart';
import 'package:amazon_flutter_application/features/admin/services/admin_services.dart';
import 'package:amazon_flutter_application/features/order_details/order_details.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  final AdminServices adminServices =AdminServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async{
    orders=await adminServices.fetchAllOrders(context);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return orders==null 
        ?const Loader():
    GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: orders!.length,
      itemBuilder: (context,index){
        final orderData=orders![index];
        return GestureDetector(
          onTap: ()
          {
              Navigator.pushNamed(context,OrderDetailsScreens.routeName,arguments:orderData);
          },
          child: SizedBox(
            height: 140,
            child: SingleProduct(
                image:orderData.products[0].images[0]),
          ),
        );
      },
    );
  }
}
