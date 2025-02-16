import 'package:amazon_flutter_application/features/home/widgets/address_box.dart';
import 'package:amazon_flutter_application/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_flutter_application/features/search/services/search_services.dart';
import 'package:amazon_flutter_application/features/search/widget/searched_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';
import '../../../constants/loader.dart';
import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName='/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Product>? products;
  SearchServices searchservices =SearchServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedproduct();
  }

  fetchSearchedproduct() async
  {
    products= await searchservices.fetchSearchProducts(context: context,
        searchQuery: widget.searchQuery);
    setState(() {

    });
  }
  void navigateToSearchScreen(String query)
  {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: GlobalVariables.appBarGradient,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(left: 15),
                      child:Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: navigateToSearchScreen,
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: (){},
                              child:Padding(
                                padding: EdgeInsets.only(
                                    left: 6
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ) ,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(top:10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: Colors.black,width:1),
                            ),
                            hintText: 'Search Amazon.in',
                          ),
                        ),
                      ) ,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 42,
                    margin: EdgeInsets.symmetric(horizontal:10),
                    child: Icon(Icons.mic,color: Colors.black),
                  )
                ],
              ),
            ),
        ),
      body: products==null?
      const Loader()
          :Column(
        children: [
          AddressBox(),
          SizedBox(height: 20,),
          Expanded(
              child:ListView.builder(
                itemCount: products!.length,
                  itemBuilder:(context,index){
                   return GestureDetector(
                     onTap:(){
                       Navigator.pushNamed(
                           context,
                           ProductDetailsScreen.routeName,
                           arguments: products![index]
                       );
                     } ,
                       child: SearchProduct(product: products![index]));
                  }
              ) )
        ],
      ),

    );
  }
}
