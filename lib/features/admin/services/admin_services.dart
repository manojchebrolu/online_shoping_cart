import 'dart:convert';
import 'dart:io';
import 'package:amazon_flutter_application/constants/error_handling.dart';
import 'package:amazon_flutter_application/constants/utils.dart';
import 'package:amazon_flutter_application/models/order.dart';
import 'package:amazon_flutter_application/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_flutter_application/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/sales.dart';

class AdminServices {
  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      print("sell product in 1");

      final cloudinary = CloudinaryPublic('dxxbdtdfy', 'bhshfhdfsai');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      print("sell product in 2");
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      print("Sending product data to the server");

      // Make HTTP request
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:3000/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product added successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      print("image not upload");
      showSnackBar(context, 'An error occurred. Please try again.');
    }

  }

  //get all the products
  Future<List<Product>>fetchAllProducts(BuildContext context) async{
    final userProvider =Provider.of<UserProvider>(context,listen: false);
    List<Product> productList =[];
   try{
     http.Response res = await http.get(
       Uri.parse('http://10.0.2.2:3000/admin/get-product'),
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



  Future<List<Order>>fetchAllOrders(BuildContext context) async{
    final userProvider =Provider.of<UserProvider>(context,listen: false);
    List<Order> orderList =[];
    try{
      http.Response res = await http.get(
        Uri.parse('http://10.0.2.2:3000/admin/get-orders'),
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


 void  changeOverStatus({required BuildContext context, required int status,
   required Order order,
 required VoidCallback onSuccess}) async{
    final userProvider =Provider.of<UserProvider>(context,listen: false);

    try{
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:3000/admin/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id':order.id,
          'status':status,
        })

      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

        },
      );
    }
    catch(e)
    {
      showSnackBar(context,e.toString());
    }

  }



  Future<Map<String,dynamic>>getEarnings(BuildContext context) async{
    final userProvider =Provider.of<UserProvider>(context,listen: false);
    List<Sales> sales =[];
    int totalEarning=0;
    try{
      http.Response res = await http.get(
        Uri.parse('http://10.0.2.2:3000/admin/analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },

      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response =jsonDecode(res.body);
          totalEarning=response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    }
    catch(e)
    {
      showSnackBar(context,e.toString());
    }
   return {
    'sales':sales,
    'totalEarnings':totalEarning
   };
  }

}
