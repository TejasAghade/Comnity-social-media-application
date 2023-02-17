// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:comnity/resources/auth_methods.dart';
import 'package:comnity/screens/feed_screen.dart';
import 'package:comnity/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatefulWidget {
  static String verify = "";

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void _signpuUser() async{

    setState(() {
      isLoading = true;
    });

    String res = await AuthMethods().signupUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!
        );

      setState(() {
        isLoading = false;
      });
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeedScreen(),));
    if(res != 'success'){
      showSnackBar(res, context);
      
    }

    

  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    String phone;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              children: [
                // ),
                const SizedBox(
                  height: 45,
                ),
                SvgPicture.asset(
                  "assets/svg/Comnity2.svg",
                  height: 84,
                ),

                const SizedBox(height: 20),

                // signup details

                // circular widget to select profile image
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 55,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : InkWell(
                          onTap: (){
                            selectImage();
                          },
                          child: CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/847/847969.png"),
                            ),
                        ),
                    Positioned(
                        bottom: -8,
                        left: 70,
                        child: IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "Enter your username",
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                    filled: true,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter your username";
                    }
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                    filled: true,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter your email";
                    }
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                    filled: true,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter your password";
                    }
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: _bioController,
                  decoration: InputDecoration(
                    hintText: "Enter your bio",
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                    filled: true,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter your bio";
                    }
                  },
                ),

                const SizedBox(
                  height: 30,
                ),

                InkWell(
                  onTap: ()=> _signpuUser(),
                  child: Container(
                    // height: 40,
                    child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Text(
                      "Signup",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        color: Color.fromRGBO(242, 108, 108, 1)),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Already have an account? "),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Container(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
