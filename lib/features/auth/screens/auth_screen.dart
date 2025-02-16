import 'package:flutter/material.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variable.dart';
import '../../services/auth_services.dart';

enum Auth
{
  signin,
  signup,
}
class AuthScreen extends StatefulWidget {
  static const String routeName='/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth=Auth.signin;
  final _signUpFormKey= GlobalKey<FormState>();
  final _signInFormKey= GlobalKey<FormState>();
  final AuthService authService=AuthService();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _nameController=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }


  void signUpUser()
  {
    authService.signUpUser(
        context: context,
        email:_emailController.text,
        password: _passwordController.text,
        name:_nameController.text
    );
  }
  void signInUser()
  {
    authService.signInUser(
        context: context,
        email:_emailController.text,
        password: _passwordController.text
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:GlobalVariables.greyBackgroundCOlor ,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
            child:Column(
              children: [
                const Text('Welcome',style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                ),
                ListTile(
                  title: const Text(
                    'Create Accont',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue:_auth,
                    onChanged: (Auth? val)
                    {
                      setState(() {
                        _auth=val!;
                      });
                    },
                  ),
                ),
                if(_auth==Auth.signup)
                  Form(
                    key: _signUpFormKey,
                    child:Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintname: "Name",
                        ),
                        SizedBox(height: 10,),
                        CustomTextField(
                          controller: _emailController,
                          hintname: "Email",
                        ),
                        SizedBox(height: 10,),
                        CustomTextField(
                          controller: _passwordController
                          ,hintname: "Password",
                        ),
                        SizedBox(height: 10),
                        CustomButton(text: "Sign Up", onTap: (){
                          print("hi");
                          if(_signUpFormKey.currentState!.validate()) {
                            print("hello");
                             signUpUser();

                          }
                        }),

                      ],
                    ) ,
                  ),
                ListTile(
                  title: const Text(
                    'Sign-in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue:_auth,
                    onChanged: (Auth? val)
                    {
                      setState(() {
                        _auth=val!;
                      });
                    },
                  ),
                ),
                if(_auth==Auth.signin)
                  Form(
                    key: _signInFormKey,
                    child:Column(
                      children: [

                        CustomTextField(
                          controller: _emailController,
                          hintname: "Email",
                        ),
                        SizedBox(height: 10,),
                        CustomTextField(
                          controller: _passwordController
                          ,hintname: "Password",
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                            text: "Sign In",
                            onTap: (){
                          if(_signInFormKey.currentState!.validate()) {
                            print("hello");
                            signInUser();

                          }
                        }),
                      ],
                    ) ,
                  ),
              ],
            )
        ),
      ),
    );
  }
}
