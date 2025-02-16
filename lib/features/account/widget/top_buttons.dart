import 'package:amazon_flutter_application/features/account/services/account_services.dart';
import 'package:amazon_flutter_application/features/account/widget/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'your Order', onTap: (){}),
            AccountButton(text: 'Turn Seller', onTap: (){}),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            AccountButton(text: 'Logout', onTap:()=>AccountServices().logout(context)),
            AccountButton(text: 'Your Wish List', onTap: (){}),
          ],
        )
      ],
    );
  }
}

