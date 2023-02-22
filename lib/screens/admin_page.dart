// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Row(
          children: [
            SvgPicture.asset("assets/svg/Comnity2.svg",
                width: 90, color: Colors.deepOrange.shade300),
            SizedBox(
              width: 10,
            ),
            Container(
                child: Text(
              "ADMIN DASHBOARD",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ))
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.2,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
