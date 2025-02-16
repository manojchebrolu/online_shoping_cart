import 'dart:convert';
import 'dart:io';
import 'package:amazon_flutter_application/constants/error_handling.dart';
import 'package:amazon_flutter_application/constants/utils.dart';
import 'package:amazon_flutter_application/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_flutter_application/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      // Make HTTP request
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/save-user-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address':address
        })
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
        User user= userProvider.user.copyWith(
           address: jsonDecode(res.body)['address'],
         );
        userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
    
      showSnackBar(context, 'An error occurred. Please try again.');
    }

  }

  //get all the products
 void placeOrder({required BuildContext context, required String address,
 required double totalSum}) async{
    final userProvider =Provider.of<UserProvider>(context,listen: false);

    try{
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'cart':userProvider.user.cart,
          'address':address,
          'totalPrice':totalSum,
        })

      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context,'Your order has been placed!');
        User user = userProvider.user.copyWith(
          cart: [],
        );
        userProvider.setUserFromModel(user);
        },
      );
    }
    catch(e)
    {
      showSnackBar(context,e.toString());
    }

  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess
  }) async{
    print("delete");
    final userProvider =Provider.of<UserProvider>(context,listen: false);

    try{
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:3000/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id':product.id}),
      );
      print("error");
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          }
      );
    }
    catch(e)
    {
      showSnackBar(context,e.toString());
    }

  }
}
