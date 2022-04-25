import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Providers/user_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/auth_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../Providers/modal_hud.dart';
import '../../Widgets/text_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  static String id='UpdateProfileScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    TextEditingController nameController=TextEditingController();
    TextEditingController phoneController=TextEditingController();
    UserModel? userModel=Provider.of<UserData>(context).user;
    emailController.text=userModel!.email;
    nameController.text=userModel.name;
    phoneController.text=userModel.phone;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: fColor,
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isChange,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/adminlogo.png'),
                              fit: BoxFit.contain,
                            )
                        ),
                      ),
                      Text(userModel.name , style: TextStyle(color: Colors.grey , fontWeight: FontWeight.w500),),
                      Text(userModel.phone),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        MyTextField(label: 'Email', picon: const Icon(Icons.email, color: fColor) , controller: emailController,
                          disable: true,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email';
                            }
                          },),
                        const SizedBox(height: 20,),
                        MyTextField(label: 'Name', picon: const Icon(Icons.person, color: fColor) , controller: nameController,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Name';
                            }
                          },),
                        const SizedBox(height: 20,),
                        MyTextField(label: 'Phone', picon: const Icon(Icons.phone, color: fColor) , controller: phoneController,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Phone';
                            }
                          },),
                         const SizedBox(height: 25,),
                        AuthButton(
                          tap: () async {
                            final instance = Provider.of<ModalHud>(context, listen: false);
                            instance.changeIsLoading(true);
                            if (_globalKey.currentState!.validate()) {
                              _globalKey.currentState!.save();
                              if (nameController.text.length < 3)
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
                                  try
                                  {
                                    await FirebaseFirestore.instance.collection('Users').doc(userModel.id).update(
                                        {
                                          'name' : nameController.text,
                                          'phone': phoneController.text,
                                        }
                                    ).then((value) {
                                      Provider.of<UserData>(context,listen: false).updateUserDate(phone: phoneController.text, name: nameController.text);
                                      instance.changeIsLoading(false);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated'),backgroundColor: Colors.green,));

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
                            else
                            {
                              instance.changeIsLoading(false);
                            }

                          },
                            text: 'Update'),

                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
