// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:comnity/screens/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerification extends StatefulWidget {
  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  

  @override
  Widget build(BuildContext context) {
    String OtpText = "";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 70),
                Text(
                  "Verify Phone Number",
                  style: TextStyle(fontSize: 32, color: Color(0xff526480)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("We have sent the verification code to"),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("+91******1488 ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Change phone number?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 95, 139, 221)),
                    )
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 68,
                        width: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              OtpText += value;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(color: Color(0x5F000000)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              OtpText += value;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(color: Color(0x5F000000)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              OtpText += value;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(color: Color(0x5F000000)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              OtpText += value;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(color: Color(0x5F000000)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              OtpText += value;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          onSaved: (otpT5) {},
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(color: Color(0x5F000000)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              OtpText += value;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          onSaved: (otpT6) {},
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(color: Color(0x5F000000)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () async {
                   
                  },
                  child: Container(
                    child: Text(
                      "Next",
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
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Resend Otp after"),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    Container(
                      child: Text(
                        "1:00",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 51, 17, 131)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    Container(
                      child: Text(
                        "s",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
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
