import 'package:amazon_flutter_application/features/address/screens/address_screen.dart';
import 'package:amazon_flutter_application/features/admin/screens/add_product_screen.dart';
import 'package:amazon_flutter_application/models/product.dart';
import 'package:flutter/material.dart';

import 'common/widgets/bottom_bar.dart';
import 'features/admin/screens/admin_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/home/screens/category_deals_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/order_details/order_details.dart';
import 'features/product_details/screens/product_details_screen.dart';
import 'features/search/screens/search_screen.dart';
import 'models/order.dart';



Route<dynamic> generateRoute(RouteSettings routeSettings)
{
  switch(routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_)=> const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_)=> const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_)=> const BottomBar(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        builder: (_)=> const AdminScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category =routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_)=>  CategoryDealsScreen(category: category),
      );
    case AddProductScreen.routName:
      return MaterialPageRoute(
        builder: (_)=> const AddProductScreen(),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
         settings: routeSettings,
        builder: (_)=> SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailsScreen.routeName:
      var product= routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=> ProductDetailsScreen(
             product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailsScreens.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreens(
          order:order
        ),
      );
    default:
      return MaterialPageRoute(
          builder:(_)=> const Scaffold(
            body: Center(
              child: Text('Screen does not'),
            ),
          )
      );
  }
}