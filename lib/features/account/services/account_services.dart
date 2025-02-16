import 'dart:convert';

import 'package:amazon_flutter_application/features/auth/screens/auth_screen.dart';
import 'package:amazon_flutter_application/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class AccountServices{
  Future<List<Order>> fetchMyProducts({
    required BuildContext context
  }) async {
    final userProvider =Provider.of<UserProvider>(context,listen: false);
    List<Order> orderList =[];
    try{
      http.Response res = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/orders/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },

      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for(int i=0;i<jsonDecode(res.body).length;i++)
          {
            orderList.add(
                Order.fromJson(
                    jsonEncode(
                      jsonDecode(res.body)[i],
                    )
                )
            );
          }
        },
      );
    }
    catch(e)
    {
      showSnackBar(context,e.toString());
    }
    return orderList;
  }
  Future<Product> fetchDealofDay({
    required BuildContext context}) async {
    final userProvider =Provider.of<UserProvider>(context,listen: false);
    Product product=Product(
        name:'',
        description:'',
        quantity: 0,
        images: [],
        category:'',
        price:0
    );
    try{
      http.Response res = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/deal-of-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },

      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            product =Product.fromJson(res.body);
          }

      );

    }
    catch(e)
    {
      showSnackBar(context,e.toString());
    }
    return product;
  }

  void logout(BuildContext context)
   async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', '');
          Navigator.pushNamedAndRemoveUntil(context,
              AuthScreen.routeName,
                  (route) =>false);


    }
    catch(e)
    {
      showSnackBar(context,e.toString());
    }
  }
}