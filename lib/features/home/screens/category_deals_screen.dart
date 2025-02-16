import 'package:amazon_flutter_application/constants/loader.dart';
import 'package:amazon_flutter_application/features/home/screens/home_screen.dart';
import 'package:amazon_flutter_application/features/home/services/home_services.dart';
import 'package:amazon_flutter_application/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_flutter_application/models/product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName='/category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices =HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProducts();
  }
  fetchCategoryProducts() async{
    print("get product");
 productList=await homeServices.fetchCategoryProducts(
     context: context,
     category: widget.category);
 setState(() {

 });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title:Text(widget.category,
            style: TextStyle(
              color: Colors.black
            ),
          )
        ),
      ),
      body: productList==null? const Loader():Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            alignment: Alignment.topLeft,
            child: Text('Keep shopping for ${widget.category}',
            style: TextStyle(
              fontSize: 20
            ),),
          ),
          SizedBox(
           height: 170,child: GridView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 15),
            itemCount: productList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
              childAspectRatio: 1.4,
              mainAxisSpacing: 10,),
              itemBuilder: (context,index){
              final product=productList![index];
                return GestureDetector(
                  onTap:(){
                    Navigator.pushNamed(context,
                        ProductDetailsScreen.routeName,
                    arguments:product);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height:130,
                        child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 0.5
                          )
                        ),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                             child: Image.network(
                                 product.images[0]
                             ),
                          ),
                        ),

                      )
                    ],
                  ),
                );
              }),
          )
        ],
      ),
    );
  }
}
