import 'package:flutter/material.dart';
import 'package:gifty/Providers/modal_hud.dart';
import 'package:gifty/Screens/User/user_home_screen.dart';
import 'package:gifty/Services/auth_services.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/auth_button.dart';
import 'package:gifty/Widgets/text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  static String id='RegistrationScreenID';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Auth auth=Auth();

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
 // Auth auth=Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Account' , style: TextStyle(color: Colors.black),),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isChange,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Let\'s Get Started' , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 25),),
                  const SizedBox(height: 5,),
                  const Text('Sign up to start your trip and get full access' , style: TextStyle(color: Colors.grey , fontSize: 18),),
                  const SizedBox(height: 50,),
                  MyTextField(label: 'Name', picon: const Icon(Icons.person , color: fColor,), controller: nameController ,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your name';
                      }
                    },),
                  const SizedBox(height: 20,),
                  MyTextField(label: 'Email', picon: const Icon(Icons.email, color: fColor), controller: emailController,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your email';
                      }
                    },),
                  const SizedBox(height: 20,),
                  MyTextField(label: 'Phone Number', picon: const Icon(Icons.phone, color: fColor), controller: phoneController,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your phone number';
                      }
                    },),
                  const SizedBox(height: 20,),
                  MyTextField(label: 'Password', picon: const Icon(Icons.lock, color: fColor), security: true ,controller: passwordController ,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your password';
                      }
                    },),
                  const SizedBox(height: 20,),
                  MyTextField(label: 'Confirm Password', picon: const Icon(Icons.lock, color: fColor),security: true, controller: confirmController,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your confirm password';
                      }
                    },),
                  const SizedBox(height: 30,),
                  Center(child: AuthButton(
                      tap: () async {
                        final instance = Provider.of<ModalHud>(context, listen: false);
                        instance.changeIsLoading(true);
                        if (_globalKey.currentState!.validate())
                        {
                          if(passwordController.text!=confirmController.text)
                            {
                              instance.changeIsLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Password should be match'),));
                            }
                          else if (nameController.text.length < 3)
                            {
                              instance.changeIsLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name Should be at least 3 character'),));
                            }
                          else if (phoneController.text.length < 9)
                            {
                              instance.changeIsLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone Number should be at lest 9 numbers'),));
                            }
                          else
                            {
                              try {
                                await auth.createAccount(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  context: context,
                                ).then((value) {
                                  instance.changeIsLoading(false);
                                  Navigator.pushNamedAndRemoveUntil(context, UserHomeScreen.id , (route)=> false);
                                });


                              }
                              catch (e) {
                                print(e);
                                List<String> a = e.toString().split(']');
                                instance.changeIsLoading(false);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${a[1].substring(1)}'),));
                              }
                            }
                        }
                        instance.changeIsLoading(false);

                      },
                      text: 'Create')),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(width: 5,),
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Text('Login here' , style: TextStyle(fontWeight: FontWeight.w500 , color: fColor),)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
