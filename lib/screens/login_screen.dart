// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:comnity/resources/auth_methods.dart';
import 'package:comnity/utils/utils.dart';
import 'package:comnity/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async{
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);

    if(res == "success"){

      setState(() {
        isLoading = false;
      });
      
      Navigator.of(context).pushNamed('/home');

    }else{

      setState(() {
        isLoading = false;
      });

      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext newContext;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                SvgPicture.asset(
                  "assets/svg/Comnity2.svg",
                  height: 84,
                ),
                const SizedBox(height: 70),
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "Enter your email",
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "Enter your password",
                    isPass: true,
                    textInputType: TextInputType.visiblePassword),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () => loginUser(),
                  child: Container(
                    child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Text(
                      "Log In",
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
                  height: 64,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Don't have an account? "),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: Container(
                        child: Text(
                          "SignUp",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
