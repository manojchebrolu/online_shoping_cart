import 'package:amazon_flutter_application/constants/loader.dart';
import 'package:amazon_flutter_application/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../model/sales.dart';

class AnaltyicsScreen extends StatefulWidget {
  const AnaltyicsScreen({super.key});

  @override
  State<AnaltyicsScreen> createState() => _AnaltyicsScreenState();
}

class _AnaltyicsScreenState extends State<AnaltyicsScreen> {
  final AdminServices adminServices =AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();
  }

  getEarnings() async{
    var earningData =await adminServices.getEarnings(context);
    totalSales =earningData['totalEarnings'];
    earnings =earningData['sales'];
    print("******************************${totalSales}");
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ?const Loader():
         Column(
           children: [
             Text('\$$totalSales',
             style: const TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold,
             ),
             )
           ],
         );
  }
}
