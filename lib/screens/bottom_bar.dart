// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:comnity/screens/home_screen_feed.dart';
// import 'package:comnity/utils/colors.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class BottomBar extends StatefulWidget {
//   const BottomBar({super.key});

//   @override
//   State<BottomBar> createState() => BottomBarState();
// }

// class BottomBarState extends State<BottomBar> {
//   int _selectedIndex = 0;

//   static final List<Widget>_widgetOptions = <Widget>[
//     const HomeScreenFeed(),
//     const Text("Messages"),
//     const Text("Upload"),
//     const Text("Notifications"),
//     const Text("Profile")
//   ];

//   void _changeScreenOnTap(int index){
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions[_selectedIndex],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: BottomNavigationBar(
//               backgroundColor: bottomBarColor,
//               currentIndex: _selectedIndex,
//               onTap: _changeScreenOnTap,
//               elevation: 10,
//               showSelectedLabels: false,
//               showUnselectedLabels: false,
//               type: BottomNavigationBarType.fixed,
//               selectedItemColor: selectedItemColor,
//               unselectedItemColor: unselectedItemColor,
//               items: [
//                 BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_home_regular),activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled), label: "Home",),
//                 BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_chat_regular),activeIcon: Icon(FluentSystemIcons.ic_fluent_chat_filled), label: "Messages"),
//                 BottomNavigationBarItem(icon: Icon(CupertinoIcons.plus_app, size: 30),activeIcon: Icon(CupertinoIcons.plus_app_fill, size: 30), label: "Upload"),
//                 BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell),activeIcon: Icon(CupertinoIcons.bell_fill), label: "Notifications"),
//                 BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_person_regular),activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled), label: "Profile")
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
  
//   }
// }