import 'dart:convert';

import 'package:amazon_flutter_application/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter_application/constants/utils.dart';
import 'package:amazon_flutter_application/features/admin/screens/admin_screen.dart';
import 'package:amazon_flutter_application/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazon_flutter_application/providers/user_provider.dart';
import '../../constants/error_handling.dart';
import '../../models/user.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          password: password,
          name: name,
          email: email,
          address: '',
          type: '',
          token: '',
          cart: []
      );
      print("inside");
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("outside");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context,
          'Account created! Login with the same credentials'
          );
        },
      );
    } catch (e) {
      showSnackBar(context,e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
          id: '',
          password: password,
          name: '',
          email: email,
          address: '',
          type: '',
          token: '',
        cart:[]
      );

      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/signin'),
        body: jsonEncode({
          'email':email,
          'password':password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs =await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token',jsonDecode(res.body)['token']);
          Provider.of<UserProvider>(context,listen:false).setUser(res.body);
          String type=Provider.of<UserProvider>(context).user.type;
          if(type=="user")
          Navigator.pushNamedAndRemoveUntil(context,BottomBar.routeName,(route)=>false);
          else
            Navigator.pushNamedAndRemoveUntil(context,AdminScreen.routeName,(route)=>false);

        },
      );
    } catch (e) {
      showSnackBar(context,e.toString());
    }
  }

  void getUserData(
     BuildContext context,
      ) async {
    try {

      SharedPreferences prefs =await SharedPreferences.getInstance();
      String? token =prefs.getString('x-auth-token');
      if(token==null)
        {
          prefs.setString('x-auth-token','');
        }
      var tokenRes = await http.post(
        Uri.parse('http://10.0.2.2:3000/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':token!
        },
      );
      var response=jsonDecode(tokenRes.body);

      if(response==true)
        {
          http.Response userRes= await http.post(
            Uri.parse('http://10.0.2.2:3000/tokenIsValid'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token':token
            },
          );
          var userProvider =Provider.of<UserProvider>(context,listen: false);
          userProvider.setUser(userRes.body);
        }
    } catch (e) {
      showSnackBar(context,e.toString());
    }
  }

}