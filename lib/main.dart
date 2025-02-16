import 'package:amazon_flutter_application/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter_application/features/admin/screens/admin_screen.dart';
import 'package:amazon_flutter_application/features/auth/screens/auth_screen.dart';
import 'package:amazon_flutter_application/features/home/screens/home_screen.dart';
import 'package:amazon_flutter_application/features/services/auth_services.dart';
import 'package:amazon_flutter_application/providers/user_provider.dart';
import 'package:amazon_flutter_application/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/global_variable.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService asuthSerice =AuthService();
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asuthSerice.getUserData(context);
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary:GlobalVariables.secondaryColor,
          ),
          appBarTheme: AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              )
          )
      ),
      onGenerateRoute: (settings)=>generateRoute(settings),
      home:  Provider.of<UserProvider>(context).user.token.isNotEmpty?
      Provider.of<UserProvider>(context).user.type== 'user'
          ? const BottomBar():const AdminScreen()
          : const AuthScreen(),
    );
  }
}
