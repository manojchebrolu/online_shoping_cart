import 'package:amazon_flutter_application/constants/loader.dart';
import 'package:amazon_flutter_application/features/home/services/home_services.dart';
import 'package:amazon_flutter_application/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final HomeServices homeServices =HomeServices();
  Product product=Product(
      name:'',
      description:'',
      quantity: 0,
      images: [],
      category:'',
      price:0
  );

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealofDay();
  }


  @override


  fetchDealofDay() async{
     product=await homeServices.fetchDealofDay(context: context);
     setState(() {

     });

  }

  navigateToDetailScreen()
  {
    Navigator.pushNamed(
        context,
        ProductDetailsScreen.routeName,
        arguments: product);
  }
  @override
  Widget build(BuildContext context) {
    return product == null
    ?const Loader()
    :product!.name.isEmpty? const SizedBox():
    GestureDetector(
      onTap: navigateToDetailScreen,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left:10,top: 15),
            child:Text(
              'Deal of the day',
              style: TextStyle(fontSize: 20),
            ),
          ),Image.network(
            product!.images[0],
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            padding: EdgeInsets.only(left: 15,top: 5,right: 40),
            alignment: Alignment.topLeft,
            child: Text('\$1000',style: TextStyle(fontSize: 18),),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15,top: 5,right: 40),
            child: Text(
            'manoj',maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: product!.images
               .map(
                 (e) => Image.network(
                   e,
                   fit: BoxFit.fitWidth,
                   width: 100,
                   height: 100,
                 )
             ).toList(),
           ),
         )
        ],
      ),
    );
  }
}
