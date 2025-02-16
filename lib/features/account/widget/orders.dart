import 'package:amazon_flutter_application/constants/global_variable.dart';
import 'package:amazon_flutter_application/constants/loader.dart';
import 'package:amazon_flutter_application/features/account/services/account_services.dart';
import 'package:amazon_flutter_application/features/account/widget/single_product.dart';
import 'package:amazon_flutter_application/features/order_details/order_details.dart';
import 'package:amazon_flutter_application/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
 List<Order>? orders;
 final AccountServices accountServices =AccountServices();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders=await accountServices.fetchMyProducts(context: context);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return orders== null ?const Loader():Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:const EdgeInsets.only(left: 15),
              child: Text('Your Orders',style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),),
            ),
            Container(
              padding:const EdgeInsets.only(right: 15),
              child: Text('see more',style: TextStyle(
                fontSize: 15,
                color: GlobalVariables.selectedNavBarColor,
                fontWeight: FontWeight.normal,
              ),),
            ),

          ],
        ),
        Container(
          height:170,
          padding: const EdgeInsets.only(left: 10,top: 20,right: 0),
          child:ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:orders!.length,
              itemBuilder: ((context,index){
               return GestureDetector(
                 onTap: (){
                   Navigator.pushNamed(
                       context,
                       OrderDetailsScreens.routeName,
                       arguments: orders![index]
                   );
                 },
                   child: SingleProduct(image: orders![index].products[0].images[0]));
          })),
        )

      ],
    );
  }
}
