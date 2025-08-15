import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/chat/view/chatting_page.dart';
import 'package:pet_app/presentation/screens/chat/view/message_page.dart';
import 'package:pet_app/presentation/screens/explore/view/explore_screen.dart';
import 'package:pet_app/presentation/screens/home/View/home_screen.dart';
import 'package:pet_app/presentation/screens/my_pets/view/all_pets_screen.dart';
import 'package:pet_app/presentation/screens/my_pets/view/my_details_pets_screen.dart';
import 'package:pet_app/presentation/screens/profile/profile_screen.dart';

class NavigationControllerMain extends GetxController {

  RxInt selectedNavIndex = 0.obs;

  List<Widget> getPages() {
    return [
      HomeScreen(),
      ExploreScreen(),
      MessageListPage(),
      AllPetsScreen(),
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
