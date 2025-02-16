import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import 'package:flutter/material.dart';

import '../../../providers/user_provider.dart';
class HomeServices {
  Future<List<Product>> fetchCategoryProducts({required BuildContext context,required String category}) async {
    final userProvider =Provider.of<UserProvider>(context,listen: false);
    List<Product> productList =[];
    try{
      http.Response res = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/products?category=$category'),
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
            productList.add(
                Product.fromJson(
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
    return productList;
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
}