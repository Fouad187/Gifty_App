import 'package:flutter/material.dart';
import 'package:gifty/Providers/modal_hud.dart';

import 'package:gifty/Screens/Auth/register_screen.dart';
import 'package:gifty/Services/auth_services.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/auth_button.dart';
import 'package:gifty/Widgets/text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id='LoginScreenID';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Auth auth=Auth();

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  //Auth auth=Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isChange,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Image(
                        image: AssetImage(
                          'assets/images/login.png',
                        ),
                        height: 200.0,
                        width: 200.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Center(child: Text('Gifty' , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 28 , color: fColor),)),
                  const SizedBox(height: 5,),
                  const Center(child: Text('Sign in to enjoy your shopping trip' , style: TextStyle(color: Colors.black45 , fontSize: 18),),),
                  const SizedBox(height: 40,),
                  MyTextField(label: 'Email', picon: const Icon(Icons.email, color: fColor) , controller: emailController,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your email';
                      }
                    },),
                  const SizedBox(height: 20,),
                  MyTextField(label: 'Password', picon: const Icon(Icons.lock, color: fColor), controller: passwordController ,security: true,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your password';
                      }
                    },),
                  const SizedBox(height: 30,),
                  Center(
                    child: AuthButton(
                      text: 'LOG IN',
                      tap: () async {
                        final instance = Provider.of<ModalHud>(context, listen: false);
                        instance.changeIsLoading(true);
                        if (_globalKey.currentState!.validate()) {
                          _globalKey.currentState!.save();
                          try
                          {
                            await auth.signIn(email: emailController.text , password: passwordController.text , context: context);
                          }
                          catch (e) {
                            print(e);
                            List<String> a = e.toString().split(']');
                            instance.changeIsLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${a[1].substring(1)}'),));
                          }
                        }
                        else
                          {
                            instance.changeIsLoading(false);
                          }

                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      const SizedBox(width: 5,),
                      InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, RegistrationScreen.id);
                          },
                          child: const Text('Sing Up' , style: TextStyle(fontWeight: FontWeight.w500 , color: fColor),)),
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
