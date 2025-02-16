import 'package:amazon_flutter_application/constants/global_variable.dart';
import 'package:amazon_flutter_application/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void navigateToCategoryPage(BuildContext context,String category)
  {
   Navigator.pushNamed(context,CategoryDealsScreen.routeName,arguments:category );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child:ListView.builder(
        itemExtent: 75,
        itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
           return GestureDetector(
             onTap: ()=>navigateToCategoryPage(context,
                 GlobalVariables.categoryImages[index]['title']!),
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 10),
                   child:ClipRRect(
                     borderRadius: BorderRadius.circular(50),
                     child: Image.asset(GlobalVariables.categoryImages[index]['image']!,
                     fit: BoxFit.cover,
                       height:40,
                       width:40,
                     ),
                   ) ,
                 ),
                 Text(GlobalVariables.categoryImages[index]['title']!,
                 style: TextStyle(
                   fontSize: 12
                 ),
                 )

               ],
             ),
           );
          }
      ),
    );
  }
}
