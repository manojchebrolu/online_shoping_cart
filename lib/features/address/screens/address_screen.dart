import 'package:amazon_flutter_application/constants/utils.dart';
import 'package:amazon_flutter_application/features/home/screens/home_screen.dart';
import 'package:amazon_flutter_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variable.dart';
import '../services/address_services.dart';


class AddressScreen extends StatefulWidget {

  static const String routeName="/address-screen";
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
   String addressToUsed="";
  final TextEditingController flatBuildingController =TextEditingController();
  final TextEditingController areaController =TextEditingController();
  final TextEditingController pincodeController =TextEditingController();
  final TextEditingController cityController =TextEditingController();
  final _addressFormKey =GlobalKey<FormState>();

  final AddressServices addressServices =AddressServices();

  void payPressed(String addressFromProvider)
  {
    addressToUsed ="";
    bool isForm =flatBuildingController.text.isNotEmpty ||
    areaController.text.isNotEmpty ||
    pincodeController.text.isNotEmpty ||
    cityController.text.isNotEmpty;

    if(isForm)
      {
        if(_addressFormKey.currentState!.validate()){
          addressToUsed='${flatBuildingController.text},${areaController.text},${pincodeController.text}-${cityController.text}';
        }
        else{
          throw Exception('please enter all the values!');
        }
      }
    else if(addressFromProvider.isNotEmpty){
      addressToUsed=addressFromProvider;
    }
    else
      {
       showSnackBar(context,'Error');
      }
   addressServices.saveUserAddress(
       context: context,
       address: addressToUsed
   );
    addressServices.placeOrder(
        context: context,
        address: addressToUsed,
        totalSum:double.parse(widget.totalAmount)
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var address =context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize:const Size.fromHeight(60),
          child:AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
          )
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if(address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                          child: Text(address,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          )),
                    )
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "OR",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _addressFormKey,
                child:Column(
                  children: [
                    CustomTextField(
                      controller:  flatBuildingController ,
                      hintname: "Flat,House no,Building",
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      controller: areaController,
                      hintname: "Area",
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      controller: pincodeController,
                      hintname: "pincode",
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      controller:cityController
                      ,hintname: "Town/city",
                    ),
                    SizedBox(height: 10,),
                   CustomButton(text: 'Order Now', onTap:()=> payPressed(address)
                   )
                  ],
                ) ,
              ),
            ]
          ),
        ),
      ),
    );
  }
}
