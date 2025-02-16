import 'package:amazon_flutter_application/common/widgets/custom_button.dart';
import 'package:amazon_flutter_application/features/address/screens/address_screen.dart';
import 'package:amazon_flutter_application/features/cart/widgets/card_product.dart';
import 'package:amazon_flutter_application/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_flutter_application/features/home/widgets/address_box.dart';
import 'package:amazon_flutter_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';
import '../../search/screens/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {



  void navigateToSearchScreen(String query)
  {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  void navigateToAddressScreen(int sum)
  {
    Navigator.pushNamed(context, AddressScreen.routeName,arguments:sum.toString());

  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
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
        child: Column(
          children: [
            AddressBox(),
            CartSubtotal(),
            CustomButton(text: 'Proceed to Buy (${user.cart.length}', onTap:()=>navigateToAddressScreen(sum)),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return CardProduct(index: index);

              },
            )
          ],
        ),
      ),
    );
  }
}
