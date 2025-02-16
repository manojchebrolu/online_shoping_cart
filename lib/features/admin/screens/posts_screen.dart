import 'package:amazon_flutter_application/constants/loader.dart';
import 'package:amazon_flutter_application/features/admin/screens/add_product_screen.dart';
import 'package:amazon_flutter_application/features/admin/services/admin_services.dart';
import 'package:amazon_flutter_application/models/product.dart';
import 'package:flutter/material.dart';

import '../../account/widget/single_product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});


  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  AdminServices adminServices=AdminServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   fetchAllProducts();
  }
  void deleteProduct(Product product, int index) {
    print("delete product");
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
    print(products);
  }

  fetchAllProducts() async{
    products= await adminServices.fetchAllProducts(context);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return products==null ?
    const Loader():
    Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: GridView.builder(
          itemCount: products!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2)
            , itemBuilder:(context,index){
              final productData=products![index];
              return Column(
                children: [
                  SizedBox(
                    height: 140,
                    child: SingleProduct(
                            image: productData.images[0],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child:Text(
                            productData.name,overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                      ),
                      IconButton(onPressed:()=> deleteProduct(productData,index),
                          icon:Icon(Icons.delete_outlined))
                    ],
                  ),
                ],
              );
        })
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context,AddProductScreen.routName);
      },
      tooltip: 'Add a Product',
      child:const Icon(Icons.add),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
