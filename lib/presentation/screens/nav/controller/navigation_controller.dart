import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/chat/chat_screen.dart';
import 'package:pet_app/presentation/screens/explore/explore_screen.dart';
import 'package:pet_app/presentation/screens/home/home_screen.dart';
import 'package:pet_app/presentation/screens/my_pets/my_pets_screen.dart';
import 'package:pet_app/presentation/screens/profile/profile_screen.dart';

class NavigationControllerMain extends GetxController {
  static NavigationControllerMain get to => Get.find();

  RxInt selectedNavIndex = 0.obs;

  List<Widget> getPages() {
    return [
      HomeScreen(),
      ExploreScreen(),
      ChatScreen(),
      MyPetsScreen(),
      ProfileScreen(),
    ];
  }


  // List of icons for the navigation bar
  final List<String> icons = [
    "assets/icons/homeicon.svg",
    "assets/icons/exploreicon.svg",
    "assets/icons/chaticon.svg",
    "assets/icons/mypeticon.svg",
    "assets/icons/profileicon.svg",
  ];

  // List of labels for the navigation bar
  final List<String> labels = [
    "Home",
    "Explore",
    "Chat",
    "My Pets",
    "Profile",
  ];
}
