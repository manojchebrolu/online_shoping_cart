import 'dart:io';

import 'package:amazon_flutter_application/common/widgets/custom_textfield.dart';
import 'package:amazon_flutter_application/constants/utils.dart';
import 'package:amazon_flutter_application/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../constants/global_variable.dart';

class AddProductScreen extends StatefulWidget {
  static const String routName='/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController=TextEditingController();
  final TextEditingController descriptionController=TextEditingController();
  final TextEditingController priceController=TextEditingController();
  final TextEditingController quantityController=TextEditingController();
  final AdminServices adminServices=AdminServices();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }
  String category='Mobiles';
  List<File> images=[];

  final _addProductFormKey =GlobalKey<FormState>();
  List<String> productCategories=[
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void selectImage() async{
    print("file picker");
    var res=await pickImages();
    print(res);
    setState(() {
      images=res;
    });

  }

  void sellProduct()
  {
    print("sell");
    if(_addProductFormKey.currentState!.validate() && images.isNotEmpty)
      {

        adminServices.sellProduct(context: context,
            name: productNameController.text,
            description: descriptionController.text,
            price: double.parse(priceController.text),
            quantity: double.parse(quantityController.text),
            category: category,
            images: images
        );
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(

            children: [
              Container(
                alignment: Alignment.center,
                child: Text("Add Product",style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),)
              ),
            ],
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
               images.isNotEmpty ?
               CarouselSlider(
                 items:images.map(
                       (i){
                     return Builder(
                       builder: (BuildContext context)=> Image.file(
                         i,
                         fit: BoxFit.cover,
                         height: 200,
                       ),
                     );
                   },).toList(),
                 options:CarouselOptions(
                     viewportFraction: 1,
                     height: 200
                 ),
               )
                   : GestureDetector(
                  onTap: selectImage,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: [10,4],
                      strokeCap:StrokeCap.round ,
                      child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.folder_open,size: 40),
                        const SizedBox(height: 15),
                        Text('Select Product Image',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade900
                        ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
                SizedBox(height: 30),
                CustomTextField(controller: productNameController,
                    hintname: "Product Name"),
                SizedBox(height: 10),
                CustomTextField(controller: descriptionController,
                    hintname: "Description",maxLines: 5,),
                SizedBox(height: 10),
                CustomTextField(controller: priceController,
                    hintname: "Price"),
                SizedBox(height: 10),
                CustomTextField(controller: quantityController,
                    hintname: "Quantity"),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  child: CustomButton(
                      text: 'Sell',
                      onTap:sellProduct
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
