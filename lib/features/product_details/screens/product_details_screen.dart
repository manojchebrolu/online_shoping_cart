import 'package:amazon_flutter_application/common/widgets/custom_button.dart';
import 'package:amazon_flutter_application/common/widgets/stars.dart';
import 'package:amazon_flutter_application/features/product_details/services/product_details_services.dart';
import 'package:amazon_flutter_application/models/product.dart';
import 'package:amazon_flutter_application/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../search/screens/search_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName='/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =ProductDetailsServices();
  double avgRating =0;
  double myRating=0;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }

  }

  void navigateToSearchScreen(String query)
  {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }
  void addToCart()
  {
    productDetailsServices.addTOCart(
        context: context,
        product: widget.product
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.all(8.0),
            child:Row(
              children: [
                Text(
                    widget.product.id!
                ),
                Stars(
                    rating: avgRating
                ),

              ],
            )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15
                ),
              ),
            ),
      CarouselSlider(
        items:widget.product.images.map(
              (i){
            return Builder(
              builder: (BuildContext context)=> Image.network(i,
                fit: BoxFit.contain,
                height: 300,
              ),
            );
          },).toList(),
        options:CarouselOptions(
            viewportFraction: 1,
            height: 300
        ),
      ), Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(padding: const EdgeInsets.all(8),
            child: RichText(
              text:TextSpan(
                text: 'Deal Prices: ',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: '\$${widget.product.price}',
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.bold
                    )
                  )
                ]
              ),
              
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                  text:'Buy Now',
                  onTap: (){}
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                  text:'Add to Cart',
                  onTap: addToCart
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Rate The Product", style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),),
            ),
            RatingBar.builder(
              initialRating: 0,
                minRating: 1,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context,_)=> const Icon(Icons.star,
                color: GlobalVariables.secondaryColor,
                ),
                onRatingUpdate: (rating){
                print('rating-1');
                  productDetailsServices.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating);
                }
            ),
          ],
        ) ,
      ),
    );
  }
}
