import 'package:amazon_flutter_application/features/home/widgets/top_categories.dart';
import 'package:amazon_flutter_application/features/search/screens/search_screen.dart';
import 'package:amazon_flutter_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../widgets/address_box.dart';
import '../widgets/carousel_image.dart';
import '../widgets/deal_of_the_day.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName="/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void navigateToSearchScreen(String query)
  {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: PreferredSize(
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
            )
        ),
      body: Column(
        children: [
          AddressBox(),
          SizedBox(height: 10),
          TopCategories(),
          SizedBox(height: 10),
          CarouselImage(),
          SizedBox(height: 10,),
          DealOfTheDay()
        ],
      ),

    );
  }
}
